defmodule MarsWeb.StatusView do
  use MarsWeb, :view
  alias MarsWeb.StatusView

  def render("status.json", _) do
    %{
      status: "up"
    }
  end
end
