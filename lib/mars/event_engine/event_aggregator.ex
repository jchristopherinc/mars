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
    {:consumer, :ok, subscribe_to: [{EventCollector, min_demand: 1, max_demand: 100}]}
  end

  @doc """
  Actual processing of events happen here! 🎉
  """
  def handle_events(events, _from, state) do
    Logger.debug "events #{inspect events}"
    for event <- events do
      Logger.debug "event in EventAggregator #{inspect event}"
    end
    {:noreply, [], state}
  end

end