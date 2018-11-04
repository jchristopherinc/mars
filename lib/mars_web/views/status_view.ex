defmodule MarsWeb.StatusView do
  use MarsWeb, :view

  @doc """
  Returns a static JSON as Health Check response
  """
  def render("status.json", _) do
    %{
      status: "up"
    }
  end
end
