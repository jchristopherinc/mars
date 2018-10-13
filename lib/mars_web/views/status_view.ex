defmodule MarsWeb.StatusView do
  use MarsWeb, :view
  alias MarsWeb.StatusView

  @doc """
  Returns a static JSON as Health Check response
  """
  def render("status.json", _) do
    %{
      status: "up"
    }
  end
end
