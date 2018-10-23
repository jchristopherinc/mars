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
  def start_link() do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @doc """
  Starts a permanent subscription to upstream Mars.EventEngine.EventCollector
  which will automatically start requesting items.
  """
  def init(:ok) do
    batch_size = 10

    sync_offset = 100

    interval = 10_000

    Process.send_after(self(), :ask, sync_offset)

    state = %{batch_size: batch_size, interval: interval}

    IO.inspect "State: #{inspect state}"

    Logger.debug "AGgregator inited"
    
    {:consumer, state, subscribe_to: [EventCollector]}
  end

  @doc """
  Handling subscription
  Set the subscription to manual to control when to ask for events
  """
  def handle_subscribe(:producer, _opts, from, state) do
    Logger.debug "handle subscribe"
    {:manual, Map.put(state, :producer, from)}
  end

  # Make the subscriptions to auto for consumers
  def handle_subscribe(:consumer, _, _, state) do
    Logger.debug "handle subscribe consumer"
    {:automatic, state}
  end

  @doc """
  Actual processing of events happen here! 🎉
  """
  def handle_events(events, _from, state) do
    for event <- events do
      Logger.debug "event in EventAggregator #{inspect event}"
    end
    {:noreply, [], state}
  end

  @doc """
  Requests a certain amount of items to process on a set interval
  """
  def handle_info(:ask, %{batch_size: batch_size, interval: interval, producer: producer} = state) do
    Logger.debug "handle info in aggregator"

    # Request a batch of events with a max batch size
    GenStage.ask(producer, batch_size)

    Logger.debug "asked for events"

    # Schedule the next request
    Process.send_after(self(), :ask, interval)

    {:noreply, [], state}
  end

end