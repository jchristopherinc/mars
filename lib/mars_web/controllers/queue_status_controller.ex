defmodule MarsWeb.QueueStatusController do
  use MarsWeb, :controller

  require Logger
  alias Mars.EventEngine.EventCollector

  @moduledoc """
  Status Check end point
  """

  @doc """
  Gives the EventCollector GenStage Queue status when requested by /api/q/stats Endpoint
  Returns 200
  {"event_collector_queue": <number> }
  """
  def get_status(conn, _params) do
    event_collector_queue_length = EventCollector.queue_length()

    Logger.debug("Queue collector length : #{inspect(event_collector_queue_length)}")

    event_collector_queue_length =
      if is_nil(event_collector_queue_length) do
        0
      else
        event_collector_queue_length
      end

    queue_stats = %{
      :event_collector_q => event_collector_queue_length
    }

    conn
    |> put_status(:ok)
    |> put_resp_header("content-type", "application/json")
    |> render("qstatus.json", %{stats: queue_stats})
  end
end
