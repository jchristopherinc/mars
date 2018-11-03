defmodule Mars.EventEngine.EventStore do
  use GenStage
  require Logger

  alias Mars.EventEngine.EventStore
  alias Mars.EventEngine.EventAggregator

  @moduledoc """
  Place to actually store Events into DB

  EventCollector <- EventAggregator <- [** EventStore **] 
  """

  @doc """
  Genstage start link. Used by Application supervisor to start the genstage
  """
  def start_link() do
    GenStage.start_link(EventStore, :ok, name: __MODULE__)
  end

  @doc """
  Establishes subscription to EventAggregator
  """
  def init(:ok) do
    {:consumer, :ok, subscribe_to: [EventAggregator]}
  end

  def handle_events(events, _from, state) do
  
    Logger.debug("IN STARTLINK")

    count = Enum.count(events)
    Logger.debug("STARTLINK count, #{inspect count}")

    # events
    # |> IO.inspect

    #store it asynchronously
    Task.start_link(fn ->
      Logger.debug("EVENT IN EVENTSTORE #{inspect(events)}")
    end)

    # no events emitted for consumer
    {:noreply, [], state}
  end
end