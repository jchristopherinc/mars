defmodule Mars.TrackTest do
  use Mars.DataCase

  alias Mars.Track

  describe "event" do
    alias Mars.Track.Event

    @valid_attrs %{app_id: "some app_id", created_at: "2010-04-17 14:00:00.000000Z", event: "some event", message_id: "some message_id"}
    @update_attrs %{app_id: "some updated app_id", created_at: "2011-05-18 15:01:01.000000Z", event: "some updated event", message_id: "some updated message_id"}
    @invalid_attrs %{app_id: nil, created_at: nil, event: nil, message_id: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Track.create_event()

      event
    end

    test "list_event/0 returns all event" do
      event = event_fixture()
      assert Track.list_event() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Track.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Track.create_event(@valid_attrs)
      assert event.app_id == "some app_id"
      assert event.created_at == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert event.event == "some event"
      assert event.message_id == "some message_id"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Track.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = Track.update_event(event, @update_attrs)

      
      assert event.app_id == "some updated app_id"
      assert event.created_at == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert event.event == "some updated event"
      assert event.message_id == "some updated message_id"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Track.update_event(event, @invalid_attrs)
      assert event == Track.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Track.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Track.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Track.change_event(event)
    end
  end
end
