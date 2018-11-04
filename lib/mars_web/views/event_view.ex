defmodule MarsWeb.EventView do
  use MarsWeb, :view
  alias MarsWeb.EventView

  @doc """
  Returns a static success response whenever a event is created.
  """
  def render("create_event.json", _) do
    %{
      success: true
    }
  end
end
