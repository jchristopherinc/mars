defmodule MarsWeb.StatusController do
  use MarsWeb, :controller

  @moduledoc """
  Status Check end point
  """

  @doc """
  Gives the App Server status when requested by Health Check
  Returns 200
  {"status": "up"}
  """
  def get_status(conn, _params) do
    conn
    |> put_status(:ok)
    |> put_resp_header("content-type", "application/json")
    |> render("status.json")
  end
end
