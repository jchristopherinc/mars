defmodule MarsWeb.EventControllerTest do
  use MarsWeb.ConnCase

  alias Mars.Track
  alias Mars.Track.Event

  @create_attrs %{
    app_id: "some app_id",
    created_at: "2010-04-17 14:00:00.000000Z",
    event: "some event",
    message_id: "some message_id"
  }
  @update_attrs %{
    app_id: "some updated app_id",
    created_at: "2011-05-18 15:01:01.000000Z",
    event: "some updated event",
    message_id: "some updated message_id"
  }
  @invalid_attrs %{app_id: nil, created_at: nil, event: nil, message_id: nil}

  def fixture(:event) do
    {:ok, event} = Track.create_event(@create_attrs)
    event
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all event", %{conn: conn} do
      conn = get(conn, Routes.event_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create event" do
    test "renders event when data is valid", %{conn: conn} do
      conn = post(conn, Routes.event_path(conn, :create), event: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.event_path(conn, :show, id))

      assert %{
               "id" => id,
               "app_id" => "some app_id",
               "created_at" => "2010-04-17 14:00:00.000000Z",
               "event" => "some event",
               "message_id" => "some message_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.event_path(conn, :create), event: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update event" do
    setup [:create_event]

    test "renders event when data is valid", %{conn: conn, event: %Event{id: id} = event} do
      conn = put(conn, Routes.event_path(conn, :update, event), event: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.event_path(conn, :show, id))

      assert %{
               "id" => id,
               "app_id" => "some updated app_id",
               "created_at" => "2011-05-18 15:01:01.000000Z",
               "event" => "some updated event",
               "message_id" => "some updated message_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, event: event} do
      conn = put(conn, Routes.event_path(conn, :update, event), event: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete event" do
    setup [:create_event]

    test "deletes chosen event", %{conn: conn, event: event} do
      conn = delete(conn, Routes.event_path(conn, :delete, event))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.event_path(conn, :show, event))
      end
    end
  end

  defp create_event(_) do
    event = fixture(:event)
    {:ok, event: event}
  end
end
