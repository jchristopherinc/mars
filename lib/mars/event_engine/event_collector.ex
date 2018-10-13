defmodule Mars.EventEngine.EventCollector do
  use GenStage

  require Logger

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
    {:producer, {:queue.new, 0, 0}, dispatcher: GenStage.BroadcastDispatcher}   
  end

  ## Callback

  @doc """
  Handle the cast generated when an Event is enqueued
  """
  def handle_cast({:enqueue, event}, {queue, demand, queue_size}) do
    Logger.debug "In Genstage handle cast"                                                                                             
    dispatch_events(:queue.in(event, queue), demand, [], queue_size + 1)                                                                                                    
  end

  @doc """
  Handle the demand by consumers, to push event from this Genstage to downstream
  """
  def handle_demand(incoming_demand, {queue, demand, queue_size}) do
    Logger.debug "In Genstage handle demand"                                                                                                 
    dispatch_events(queue, incoming_demand + demand, [], queue_size)                                                                                                      
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
  defp dispatch_events(queue, demand, events, queue_size) do
    Logger.debug "In dispatch events"
    Logger.debug "queue_size #{queue_size}"
    Logger.debug "queue #{inspect queue}"
    Logger.debug "demand #{demand}"

    with d when d > 0 <- demand,                                                                                                                                          
        {item, queue} = :queue.out(queue),                                                                                                                                
        {:value, event} <- item do
      Logger.debug "printing event..."
      Logger.debug event
    else                                                                                                                                                                  
      _ -> {:noreply, Enum.reverse(events), {queue, demand, queue_size}}                                                                                                  
    end   
    
  end                                                                                                                                                                     
end