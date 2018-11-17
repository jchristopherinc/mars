defmodule MarsWeb.QueueStatusControllerTest do
  use MarsWeb.ConnCase

  test "GET /api/q/stats", %{conn: conn} do
    conn = get(conn, "/api/q/stats")
    assert json_response(conn, 200)["event_collector_queue"] >= 0
  end
end
