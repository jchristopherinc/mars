defmodule Mars.EventEngine.EventAggregator do
  use GenStage

  require Logger

  alias Mars.EventEngine.EventCollector

  @moduledoc """
  Events are pushed to the queue from EventController. 
  EventCollector is a queue to receive all these events from APIs for further downstream processing

  EventCollector <- [** EventAggregator **] <- EventStore
  """

  ## Link and Init

  @doc """
  Genstage start link. Used by Application supervisor to start the genstage
  """
  def start_link(id) do
    name = :"#{__MODULE__}:#{id}"
    GenStage.start_link(__MODULE__, :ok, name: name)
  end

  @doc """
  Starts a permanent subscription to upstream Mars.EventEngine.EventCollector
  which will automatically start requesting items.

  Gets events in batch_size of 10 and periodically for every 10 seconds
  """
  def init(:ok) do
    batch_size = 1_000

    sync_offset = 0

    interval = 1_000

    Process.send_after(self(), :ask, sync_offset)

    state = %{batch_size: batch_size, interval: interval}

    {:producer_consumer, state,
     subscribe_to: [{EventCollector, min_demand: 1_000, max_demand: 2_000}]}
  end

  # callbacks

  @doc """
  Handling subscription
  Set the subscription to manual to control when to ask for events
  """
  def handle_subscribe(:producer, _opts, from, state) do
    # Logger.debug "handle subscribe"
    {:manual, Map.put(state, :producer, from)}
  end

  # Make the subscriptions to auto for consumers
  def handle_subscribe(:consumer, _, _, state) do
    {:automatic, state}
  end

  @doc """
  Actual processing of events happen here! 🎉
  """
  def handle_events(events, _from, state) do
    # group events by message_id
    grouped_events =
      events
      |> Enum.group_by(fn entry -> entry.message_id end)

    {:noreply, [grouped_events], state}
  end

  @doc """
  Requests a certain amount of items to process on a set interval
  """
  def handle_info(:ask, %{batch_size: batch_size, interval: interval, producer: producer} = state) do
    # Request a batch of events with a max batch size
    GenStage.ask(producer, batch_size)

    # Schedule the next request
    Process.send_after(self(), :ask, interval)

    {:noreply, [], state}
  end
end
