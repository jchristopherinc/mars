defmodule MarsWeb.EventController do
  use MarsWeb, :controller
  use Timex

  require Logger

  alias Mars.EventEngine.EventCollector
  alias Mars.Track
  alias MarsWeb.EventTimelineChannel

  action_fallback(MarsWeb.FallbackController)

  @max_generate_test_events 1

  @moduledoc """
  EventController to expose APIs for public consumption
  """

  # Public API

  @doc """
  A public metbod to accept event from different systems/agent and enqueue it to EventCollector Genstage

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

    # enqueue event into the event collector
    EventCollector.enqueue(event)

    conn
    |> put_status(:ok)
    |> put_resp_header("content-type", "application/json")
    |> render("create_event.json")
  end

  @doc """
  A public metbod to accept bulk events from different systems/agent and enqueue it to EventCollector Genstage
  """
  def create_events(conn, %{"events" => events}) do
    Enum.each(events, fn event ->
      event_to_enqueue = %{
        app_id: event.app_id,
        message_id: event.message_id,
        event: event.event,
        created_at: event.created_at,
        external_id: event.external_id
      }

      # enqueue event into the event collector
      EventCollector.enqueue(event_to_enqueue)
    end)

    conn
    |> put_status(:ok)
    |> put_resp_header("content-type", "application/json")
    |> render("create_event.json")
  end

  @doc """
  A public method to get list of events based on message_id
  """
  def list_events(conn, %{"message_id" => message_id}) do
    if !is_nil(message_id) do
      message_with_event = Track.get_event_by_message_id(message_id)

      if is_nil(message_with_event) do
        conn
        |> put_status(:ok)
        |> render("index.html", success: false, message_id: message_id)
      else
        conn
        |> put_status(:ok)
        |> render("index.html",
          success: true,
          message_id: message_with_event.message_id,
          app_id: message_with_event.app_id,
          event: message_with_event.event
        )
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

    for i <- 1..@max_generate_test_events do
      random_num = :rand.uniform(event_map_len)

      random_event = Map.get(event_map, random_num)

      random_id = :rand.uniform(10_000_000)

      event = %{
        app_id: Integer.to_string(random_id),
        message_id: Integer.to_string(random_id * 100),
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

  @doc """
  A test end point to create message lifecycle events for any message_id and push it to Websocket
  """
  def test_event_timeline_socket(conn, params) do
    message_id = params["message_id"]

    # validate input
    if is_nil(message_id) do
      conn
      |> put_status(:bad_request)
      |> put_resp_header("content-type", "application/json")
      |> render("event_failure.json")
    end

    # send test broadcast
    EventTimelineChannel.test_broadcast_events(message_id)

    # send reply to the API
    conn
    |> put_status(:ok)
    |> put_resp_header("content-type", "application/json")
    |> render("create_event.json")
  end
end
