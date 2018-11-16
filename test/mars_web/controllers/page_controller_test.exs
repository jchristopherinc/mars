defmodule MarsWeb.PageControllerTest do
  use MarsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert response(conn, 200)
  end
end
