defmodule MarsWeb.StatusControllerTest do
  use MarsWeb.ConnCase

  test "GET /status", %{conn: conn} do
    conn = get(conn, "/status")
    assert json_response(conn, 200)["status"] == "up"
  end
end
