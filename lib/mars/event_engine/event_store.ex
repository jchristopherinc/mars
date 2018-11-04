defmodule Mars.EventEngine.EventStore do
  use GenStage
  require Logger

  alias Mars.EventEngine.EventStore
  alias Mars.EventEngine.EventAggregator

  alias Mars.Track

  @moduledoc """
  Place to actually store Events into DB

  EventCollector <- EventAggregator <- [** EventStore **] 
  """

  @doc """
  Genstage start link. Used by Application supervisor to start the genstage
  """
  def start_link() do
    GenStage.start_link(EventStore, :ok, name: __MODULE__)
  end

  @doc """
  Establishes subscription to EventAggregator
  """
  def init(:ok) do
    {:consumer, :ok, subscribe_to: [EventAggregator]}
  end

  @doc """
  Handles events, creates Model object out of it and pushes it to DB.
  """
  def handle_events(events, _from, state) do

    Enum.each(events, fn event -> 
      Enum.map(event, fn{key, values} ->  
        
        val_0 = Enum.at(values, 0)

        #app_id lives inside each event
        app_id = val_0.app_id 

        event_map = 
          values 
          |> Enum.map(fn val -> {val.event, val.created_at} end)
          |> Map.new

        msg_event = %{app_id: app_id, message_id: key, event_map: event_map} #key is the message_id

        #Push it to DB
        Track.upsert_event(msg_event)
      end)
    end)

    # no events emitted for consumer
    {:noreply, [], state}
  end
end