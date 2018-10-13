defmodule MarsWeb.PageController do
  use MarsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
