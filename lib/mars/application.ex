defmodule Mars.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @max_event_collectors 10
  @max_event_aggregators 10
  @max_event_stores 10

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Mars.Repo,
      # Start the endpoint when the application starts
      MarsWeb.Endpoint
      # Starts a worker by calling: Mars.Worker.start_link(arg)
      # {Mars.Worker, arg}
    ]

    # Starting links to our EventEngine GenStages
    event_collectors =
      for id <- 1..@max_event_collectors do
        %{
          id: "EventCollector:#{id}",
          start: {
            Mars.EventEngine.EventCollector,
            :start_link,
            [
              id
            ]
          }
        }
      end

    event_aggregators =
      for id <- 1..@max_event_aggregators do
        %{
          id: "EventAggregator:#{id}",
          start: {
            Mars.EventEngine.EventAggregator,
            :start_link,
            [
                id
            ]
          }
        }
      end

    event_stores =
      for id <- 1..@max_event_stores do
        %{
          id: "EventStore:#{id}",
          start: {
            Mars.EventEngine.EventStore,
            :start_link,
            [
              {
                id,
                @max_event_aggregators
              }
            ]
          }
        }
      end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mars.Supervisor, max_restarts: 10]
    Supervisor.start_link(children ++ event_collectors ++ event_aggregators ++ event_stores, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MarsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
