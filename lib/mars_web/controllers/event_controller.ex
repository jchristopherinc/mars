defmodule MarsWeb.EventController do
  use MarsWeb, :controller
  use Timex

  require Logger

  alias Mars.Track
  alias Mars.Track.Event

  alias Mars.EventEngine.EventCollector

  action_fallback(MarsWeb.FallbackController)

  @moduledoc """
  EventController to expose APIs for public consumption
  """

  @doc """
  A temporary metbod to generate random events and enqueue it to EventCollector Genstage

  Returns HTTP Status code 200
  """
  def create_event(conn, _) do
    Logger.debug("creating event")

    event_map = %{
      1 => "MESSAGE_CREATED",
      2 => "MESSAGE_REACHED_BACKEND",
      3 => "MESSAGE_IN_SEARCH_QUEUE",
      4 => "MESSAGE_IN_UPDATES_QUEUE",
      5 => "MESSAGE_IN_WS_QUEUE",
      6 => "MESSAGE_REACHED_FRONTEND"
    }

    event_map_len = event_map |> map_size

    events =
      for i <- 1..1 do
        random_num = :rand.uniform(event_map_len)

        random_event = Map.get(event_map, random_num)

        event = %{
          app_id: i,
          message_id: i * 100,
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
