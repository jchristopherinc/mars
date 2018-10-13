defmodule Mars.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Mars.Repo,
      # Start the endpoint when the application starts
      MarsWeb.Endpoint,
      # Starts a worker by calling: Mars.Worker.start_link(arg)
      # {Mars.Worker, arg},

      # Start link for our GenStage
      %{
        id: EventCollector,
        start: {Mars.EventEngine.EventCollector, :start_link, []}
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mars.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MarsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
