defmodule MarsWeb.EventView do
  use MarsWeb, :view

  alias MarsWeb.TimeHelper

  @doc """
  Returns a static success response whenever a event is created.
  """
  def render("create_event.json", _) do
    %{
      success: true
    }
  end

  def render("event_failure.json", _) do
    %{
      success: false
    }
  end

  def parse_time(time) do
    TimeHelper.parse_time(time)
  end

  def parse_event(event) do
    String.replace(event, "_", " ")
  end
end
