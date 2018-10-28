defmodule Mars.EventEngine.EventConsumer do
  use ConsumerSupervisor

  require Logger

  @moduledoc """
  Consumer supervision strategy to create a bridge between EventAggregator and EventStore

              EventConsumer
          /                   \
  EventAggregator           EventStore
  """

  def start_link() do
    ConsumerSupervisor.start_link(__MODULE__, :ok, __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(Mars.EventEngine.EventStore, [], restart: :temporary)
    ]

    {:ok, children, strategy: :one_for_one, subscribe_to: Mars.EventEngine.EventAggregator}
  end

end