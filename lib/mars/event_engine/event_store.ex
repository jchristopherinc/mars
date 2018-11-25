defmodule Mars.EventEngine.EventStore do
  use GenStage
  require Logger

  alias Mars.Track
  alias MarsWeb.EventTimelineChannel
  alias MarsWeb.TimeHelper

  @moduledoc """
  Place to actually store Events into DB

  EventCollector <- EventAggregator <- [** EventStore **] 
  """

  @doc """
  Genstage start link. Used by Application supervisor to start the genstage
  """
  def start_link({id, subscribers}) do
    name = :"EventStore:#{id}"
    GenStage.start_link(__MODULE__, {:ok, subscribers}, name: name)
  end

  @doc """
  Establishes subscription to EventAggregator
  """
  def init({:ok, subscribers}) do
    producers =
      for id <- 1..subscribers do
        {:"Elixir.Mars.EventEngine.EventAggregator:#{id}", min_demand: 1_000, max_demand: 2_000}
      end

    {:consumer, :ok, subscribe_to: producers}
  end

  @doc """
  Handles events, creates Model object out of it and pushes it to DB.
  """
  def handle_events(events, _from, state) do
    Enum.each(events, fn event ->
      Enum.map(event, fn {key, values} ->
        val_0 = Enum.at(values, 0)

        # app_id lives inside each event
        app_id = val_0.app_id

        event_map =
          values
          |> Enum.map(&create_map/1)
          |> Map.new()

        # key is the message_id
        msg_event = %{app_id: app_id, message_id: key, event_map: event_map}

        # Push it to DB
        Track.upsert_event(msg_event)

        # Broadcast it to Websockets
        send_web_sockets(key, event_map)
      end)
    end)

    # no events emitted for consumer
    {:noreply, [], state}
  end

  @doc """
  Create a HashMap of event and created_at from overall event map, for storing it as JSON
  """
  def create_map(val) do
    {val.event, val.created_at}
  end

  @doc """
  Iterates over event_map for event transformation
  """
  defp send_web_sockets(message_id, event_map) do
    event_map
    |> Enum.each(&event_transform_and_send(&1, message_id))
  end

  @doc """
  Extracts key and value for each event in event_map and calls event_send
  """
  defp event_transform_and_send(event, message_id) do
    {key, value} = event
    event_send(key, value, message_id)
  end

  @doc """
  Creates the payload, and sends events to Websocket.
  """
  defp event_send(key, value, message_id) do    
    formatted_time = TimeHelper.mars_formatted_time(value)

    event_key =
      key
      |> String.upcase()
      |> String.replace("_", " ")

    event_for_websocket = %{
      "event" => event_key,
      "time" => formatted_time
    }

    EventTimelineChannel.broadcast_events(message_id, event_for_websocket)
  end
end
