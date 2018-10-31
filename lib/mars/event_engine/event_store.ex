defmodule Mars.EventEngine.EventStore do
  require Logger

  @moduledoc """
  Place to actually store Events into DB

  EventCollector <- EventAggregator <- [** EventStore **] 
  """

  @doc """
  Genstage start link. Used by Application supervisor to start the genstage
  """
  def start_link({event, %{"event" => event}}) do
    Task.start_link(fn ->
      Logger.debug("EVENT IN EVENTSTORE #{inspect(event)}")
    end)
  end
end
