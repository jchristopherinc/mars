# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

#local environment config
import_config "env.local.exs"

config :mars,
  ecto_repos: [Mars.Repo]

# Configures the endpoint
config :mars, MarsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5UHiq6+W5N1odHQ83rrulGFGxImuuMDRNqt4OirVNNhjsqZxyleGPaUg01KF6fau",
  render_errors: [view: MarsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mars.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix and Ecto
config :phoenix, :json_library, Jason

# Use Git Hooks to format the code
config :git_hooks,
  verbose: true,
  hooks: [
    pre_commit: [
      mix_tasks: [
        "format"
      ]
    ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
