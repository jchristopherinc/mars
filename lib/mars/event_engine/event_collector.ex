defmodule Mars.EventEngine.EventCollector do
  use GenStage

  require Logger

  alias Mars.Structures.Queue

  @moduledoc """
  Events are pushed to the queue from EventController. 
  EventCollector is a queue to receive all these events from APIs for further downstream processing

  [** EventCollector **] <- EventAggregator <- EventStore
  """

  ## Link and Init

  @doc """
  Genstage start link. Used by Application supervisor to start the genstage
  """
  def start_link() do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @doc """
  Tells what's the type of this Genstage (producer / producer-consumer / consumer), 
  initial state and dispatcher strategy
  """
  def init(:ok) do
    {:producer, {Queue.new(), 0}, dispatcher: GenStage.DemandDispatcher}   
  end

  ## Callback

  @doc """
  Handle the cast generated when an Event is enqueued
  """
  def handle_cast({:enqueue, event}, {queue, pending_demand}) do
    Logger.debug "In Genstage handle cast"   
    updated_queue = Queue.insert(queue, event)
    dispatch_events(updated_queue, pending_demand, [])                                                                                                   
  end

  @doc """
  Handle the demand by consumers, to push event from this Genstage to downstream
  """
  def handle_demand(incoming_demand, {queue, pending_demand}) do
    Logger.debug "In Genstage handle demand"                                                                                                 
    dispatch_events(queue, incoming_demand + pending_demand, [])  
  end

  ## Public method

  @doc """
  Public method to push events to EventCollector
  """
  def enqueue(event) do
    Logger.debug "In Genstage enqueue"                                                                                                                                        
    GenStage.cast(__MODULE__, {:enqueue, event})                                                                                                                         
  end  

  ## Private method

  @doc """
  Gets the events from the queue for dispatching, when requested by downstream consumers
  """
  defp dispatch_events(queue, demand, events) when demand > 0 do
    IO.inspect "demand #{demand}"

    extracted_events = get_x_events(queue, demand);

    if extracted_events != %{} do
      Logger.debug "gotcha events.. sending reply #{inspect extracted_events}"
      dispatch_events(queue, 0, [extracted_events | events]) 
    else
      Logger.debug "no more events.. sending reply"
      {:noreply, Enum.reverse(events), {queue, demand}}          
    end
  end

  @doc """
  get X events from the queue, based on the demand
  """
  defp get_x_events(queue, demand) do
    if Queue.is_empty?(queue) do
      %{}
    else
      {items, updated_queue} = Queue.take(queue, demand)
    end
  end

  defp dispatch_events(queue, 0, events) do
    {:noreply, Enum.reverse(events), {queue, 0}}
  end

end