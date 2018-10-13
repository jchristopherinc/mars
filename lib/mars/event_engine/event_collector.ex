defmodule Mars.EventEngine.EventCollector do
  use GenStage

  require Logger

  @moduledoc """
  Events are pushed to the queue from EventController. 
  EventCollector is a queue to receive all these events from APIs for further downstream processing

  [** EventCollector **] <- EventAggregator <- EventStore
  """

  def start_link() do
    GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:producer, {:queue.new, 0, 0}, dispatcher: GenStage.BroadcastDispatcher}   
  end

  def enqueue(event) do
    Logger.debug "In Genstage enqueue"                                                                                                                                        
    GenStage.cast(__MODULE__, {:enqueue, event})                                                                                                                         
  end  

  def handle_cast({:enqueue, event}, {queue, demand, queue_size}) do
    Logger.debug "In Genstage handle cast"                                                                                             
    dispatch_events(:queue.in(event, queue), demand, [], queue_size + 1)                                                                                                    
  end

  def handle_demand(incoming_demand, {queue, demand, queue_size}) do
    Logger.debug "In Genstage handle demand"                                                                                                 
    dispatch_events(queue, incoming_demand + demand, [], queue_size)                                                                                                      
  end

  # Private methods
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