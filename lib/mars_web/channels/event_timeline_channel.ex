defmodule MarsWeb.EventTimelineChannel do
  use MarsWeb, :channel

  @moduledoc """
  Realtime layer for updating events in Message - Event lifecycle page
  """

  alias MarsWeb.TimeHelper

  @doc """
  Accept Socket connections that have topic `event_timeline:<event_id/message_id>`
  """
  def join("event_timeline:" <> event_id, payload, socket) do
    if authorized?(payload) do
      {:ok, "event_timeline:#{event_id}", socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @doc """
  Channels can be used in a request/response fashion
  by sending replies to requests from the client
  """
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  @doc """
  It is also common to receive messages from the client and
  broadcast to everyone in the current topic (event_timeline:*).
  """
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  @doc """
  To handle outgoing messages out of socket. 
  Generic enough to accept anyevent from Backend to be sent over to the Frontend
  """
  def handle_out(event, payload, socket) do
    push(socket, event, payload)
    {:noreply, socket}
  end

  @doc """
  Public method to broadcast message lifecycle events to UI
  """
  def broadcast_events(message_id, events) do
    # events is already a map
    MarsWeb.Endpoint.broadcast("event_timeline:#{message_id}", "add_to_timeline", events)
  end

  @doc """
  A test method to broadcast test events to any message_id
  """
  def test_broadcast_events(message_id) do
    time = TimeHelper.mars_formatted_time(Timex.now())

    key = "Test Event for #{message_id}"

    event_key =
      key
      |> String.upcase()
      |> String.replace("_", " ")

    payload = %{
      "event" => event_key,
      "time" => time
    }

    MarsWeb.Endpoint.broadcast("event_timeline:#{message_id}", "add_to_timeline", payload)
  end

  # Private method

  @doc """
  Add authorization logic here as required.
  """
  defp authorized?(_payload) do
    true
  end
end
