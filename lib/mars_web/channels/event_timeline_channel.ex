defmodule MarsWeb.EventTimelineChannel do
  use MarsWeb, :channel

  def join("event_timeline:" <> event_id, payload, socket) do
    if authorized?(payload) do
      {:ok, "event_timeline:#{event_id}", socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (event_timeline:*).
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  def handle_out(event, payload, socket) do
    push(socket, event, payload)
    {:noreply, socket}
  end

  def broadcast_events(message_id) do
    payload = %{
      "payload" => "Event for #{message_id}"
    }

    MarsWeb.Endpoint.broadcast("event_timeline:#{message_id}", "change", payload)
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
