defmodule MarsWeb.EventController do
  use MarsWeb, :controller

  require Logger

  alias Mars.Track
  alias Mars.Track.Event

  action_fallback MarsWeb.FallbackController

  def create_event(conn, _) do
    Logger.debug "creating event"

    conn
    |> put_status(:ok)
    |> put_resp_header("content-type", "application/json")
    |> render("create_event.json")
  end

end
