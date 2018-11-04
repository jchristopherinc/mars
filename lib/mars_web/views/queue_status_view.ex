defmodule MarsWeb.QueueStatusView do
  use MarsWeb, :view
  alias MarsWeb.QueueStatusView

  @doc """
  Returns a static JSON as Health Check response
  """
  def render("qstatus.json", %{stats: stats}) do
    %{
      event_collector_queue: Map.get(stats, :event_collector_q)
    }
  end
end
