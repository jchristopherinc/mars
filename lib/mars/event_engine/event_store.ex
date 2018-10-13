defmodule Mars.EventEngine.EventStore do
  
  require Logger

  def start_link({event, %{"event" => event}}) do
    Task.start_link(fn ->
      Logger.debug "EVENT IN EVENTSTORE #{inspect event}"
    end)
  end

end