defmodule MarsWeb.StatusController do
  use MarsWeb, :controller

  def get_status(conn, _params) do
    conn
    |> put_status(:ok)
    |> put_resp_header("content-type", "application/json")
    |> render("status.json")
  end
end
