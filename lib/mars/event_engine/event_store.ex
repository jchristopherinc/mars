defmodule Mars.EventEngine.EventStore do
  use GenStage
  require Logger

  alias Mars.EventEngine.EventStore
  alias Mars.EventEngine.EventAggregator

  alias Mars.Track

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

    Enum.each(events, fn event -> 
      Enum.map(event, fn{key, values} -> 
        IO.puts key 
        
        Enum.each(values, fn value ->
          IO.puts value.app_id
        end)
      end)
    end)

    # no events emitted for consumer
    {:noreply, [], state}
  end
end