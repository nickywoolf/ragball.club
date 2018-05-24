# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ragball,
  ecto_repos: [Ragball.Repo]

# Configures the endpoint
config :ragball, RagballWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wj+jT2UUm2B/vDwnfMZ9Vee0zLnIZ0Kk+keXm7k5nT6MxVyHRQlH2L7rosoiGO3U",
  render_errors: [view: RagballWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ragball.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
