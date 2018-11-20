defmodule Mars.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @max_event_aggregators 10
  @max_event_stores 10

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Mars.Repo,
      # Start the endpoint when the application starts
      MarsWeb.Endpoint,
      # Starts a worker by calling: Mars.Worker.start_link(arg)
      # {Mars.Worker, arg},

      # Starting links to our EventEngine GenStages
      %{
        id: EventCollector,
        start: {Mars.EventEngine.EventCollector, :start_link, []}
      }
    ]

    event_aggregators =
      for id <- 1..@max_event_aggregators do
        %{
          id: "Elixir.Mars.EventEngine.EventAggregator:#{id}",
          start: {Mars.EventEngine.EventAggregator, :start_link, [id]}
        }
      end

    event_stores =
      for id <- 1..@max_event_stores do
        current_id = id + @max_event_aggregators

        %{
          id: "EventStore:#{current_id}",
          start: {Mars.EventEngine.EventStore, :start_link, [{current_id, @max_event_stores}]}
        }
      end
    
    # Starting Agents
    Mars.EventEngine.EventStateContainer.start_link()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mars.Supervisor, max_restarts: 10]

    supervisor_children = children ++ event_aggregators ++ event_stores

    Supervisor.start_link(supervisor_children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MarsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
