defmodule Mars.EventEngine.EventCollector do
  use GenStage

  require Logger

  alias Mars.EventEngine.EventStateContainer
  alias Mars.Structures.Queue

  @max_buffer_size 100_000

  @moduledoc """
  Events are pushed to the queue from EventController. 
  EventCollector is a queue to receive all these events from APIs for further downstream processing

  [** EventCollector **] <- EventAggregator <- EventStore
  """

  ## Link and Init

  @doc """
  Genstage start link. Used by Application supervisor to start the genstage
  """
  def start_link do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @doc """
  Tells what's the type of this Genstage (producer / producer-consumer / consumer), 
  initial state and dispatcher strategy
  """
  def init(:ok) do
    state_from_agent = EventStateContainer.get(:event_collector_state)

    state =
      if is_nil(state_from_agent) do
        {Queue.new(), 0}
      else
        {state_from_agent, 0}
      end

    IO.inspect("State from agent #{inspect(state)}")

    {:producer, state, dispatcher: GenStage.DemandDispatcher, buffer_size: @max_buffer_size}
  end

  ## Callbacks

  @doc """
  Handle the cast generated when an Event is enqueued
  """
  def handle_cast({:enqueue, event}, {queue, pending_demand}) do
    updated_queue = Queue.insert(queue, event)

    q_length = Queue.length(updated_queue)
    FastGlobal.put(:event_collector_q_length, q_length)

    dispatch_events(updated_queue, pending_demand, [])
  end

  @doc """
  Handle the demand by consumers, to push event from this Genstage to downstream
  """
  def handle_demand(incoming_demand, {queue, pending_demand}) do
    length = Queue.length(queue)

    if length > 0 do
      dispatch_events(queue, incoming_demand + pending_demand, [])
    else
      {:noreply, [], {queue, 0}}
    end
  end

  @doc """
    Makes sure that the state is saved before effectively
    terminating the GenServer.
  """
  def terminate(_reason, state) do
    IO.inspect("TERMINATE CALLED #{inspect(state)}")
    EventStateContainer.put(:event_collector_state, state)
    {:shutdown, state}
  end

  ## Public method

  @doc """
  Public method to push events to EventCollector
  """
  def enqueue(event) do
    GenStage.cast(__MODULE__, {:enqueue, event})
  end

  ## Private methods

  @doc """
  Gets the events from the queue for dispatching, when requested by downstream consumers
  """
  defp dispatch_events(queue, demand, events) when demand > 0 do
    {extracted_events_queue, updated_queue} = Queue.take(queue, demand)

    extracted_events = Queue.to_list(extracted_events_queue)

    if is_nil(extracted_events) do
      {:noreply, events, {queue, demand}}
    else
      FastGlobal.put(:event_collector_q_length, Queue.length(updated_queue))
      dispatch_events(updated_queue, 0, extracted_events)
    end
  end

  defp dispatch_events(queue, 0, events) do
    {:noreply, events, {queue, 0}}
  end

  def queue_length do
    FastGlobal.get(:event_collector_q_length)
  end
end
