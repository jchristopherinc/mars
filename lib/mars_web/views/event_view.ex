defmodule MarsWeb.EventView do
  use MarsWeb, :view
  alias MarsWeb.EventView

  def render("index.json", %{event: event}) do
    %{data: render_many(event, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      message_id: event.message_id,
      app_id: event.app_id,
      event: event.event,
      created_at: event.created_at}
  end

  def render("create_event.json", _) do
    %{
      success: true
    }
  end
end
