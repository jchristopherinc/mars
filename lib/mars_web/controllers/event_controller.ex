defmodule MarsWeb.EventController do
  use MarsWeb, :controller
  use Timex

  require Logger

  alias Mars.Track
  alias Mars.EventEngine.EventCollector

  action_fallback(MarsWeb.FallbackController)

  @moduledoc """
  EventController to expose APIs for public consumption
  """

  # Public API

  @doc """
  A public metbod to accept events from API and enqueue it to EventCollector Genstage

  Returns HTTP Status code 200
  """
  def create_event(
        conn,
        %{
          "app_id" => app_id,
          "message_id" => message_id,
          "event" => event,
          "created_at" => created_at
        } = params
      ) do
    # honour external_id only if it's available
    external_id = params["external_id"]

    event = %{
      app_id: app_id,
      message_id: message_id,
      event: event,
      # TODO change it to action_time
      created_at: created_at
    }

    if !is_nil(external_id) do
      Map.put(event, :external_id, external_id)
    end

    # enqueue event into the event queue    
    EventCollector.enqueue(event)

    conn
    |> put_status(:ok)
    |> put_resp_header("content-type", "application/json")
    |> render("create_event.json")
  end

  def list_events(conn, params) do
    # dunno why I need to query it this way.. sucks.. 
    message_id = params["messageId"]["messageId"]

    if !is_nil(message_id) do
      message_with_event = Track.get_event_by_message_id(message_id)

      if !is_nil(message_with_event) do
        conn
        |> put_status(:ok)
        |> render("index.html",
          success: true,
          message_id: message_with_event.message_id,
          app_id: message_with_event.app_id,
          event: message_with_event.event
        )
      else
        conn
        |> put_status(:ok)
        |> render("index.html", success: false, message_id: message_id)
      end
    end
  end

  # Internal APIs

  @doc """
  A temporary metbod to generate random events and enqueue it to EventCollector Genstage

  Returns HTTP Status code 200
  """
  def test_create_event(conn, _) do
    event_map = %{
      1 => "MESSAGE_CREATED",
      2 => "MESSAGE_REACHED_BACKEND",
      3 => "MESSAGE_IN_SEARCH_QUEUE",
      4 => "MESSAGE_IN_UPDATES_QUEUE",
      5 => "MESSAGE_IN_WS_QUEUE",
      6 => "MESSAGE_REACHED_FRONTEND"
    }

    event_map_len = event_map |> map_size

    for i <- 1..1 do
      random_num = :rand.uniform(event_map_len)

      random_event = Map.get(event_map, random_num)

      random_id = :rand.uniform(10000)

      event = %{
        app_id: random_id,
        message_id: random_id * 100,
        event: random_event,
        created_at: Timex.now()
      }

      # add events with same message_id to test aggregation :)

      # if i < 500 do
      #   random_num_2 = :rand.uniform(event_map_len)
      #   random_event_2 = Map.get(event_map, random_num_2)
      #    event2 = %{
      #     app_id: i,
      #     message_id: i * 100,
      #     event: random_event_2,
      #     created_at: Timex.now
      #   }
      #   EventCollector.enqueue(event2)
      # end

      EventCollector.enqueue(event)
    end

    conn
    |> put_status(:ok)
    |> put_resp_header("content-type", "application/json")
    |> render("create_event.json")
  end
end
