defmodule MarsWeb.EventController do
  use MarsWeb, :controller
  use Timex

  require Logger

  alias Mars.Track
  alias Mars.Track.Event

  alias Mars.EventEngine.EventCollector

  action_fallback MarsWeb.FallbackController

  def create_event(conn, _) do
    Logger.debug "creating event"

    event = %Event {
      app_id: "1",
      message_id: "100",
      event: "MESSAGE_CREATED",
      created_at: Timex.now
    }
    
    EventCollector.enqueue(event)

    Logger.debug "Event queued"

    conn
    |> put_status(:ok)
    |> put_resp_header("content-type", "application/json")
    |> render("create_event.json")
  end

end
