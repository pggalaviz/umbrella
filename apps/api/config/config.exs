# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api,
  namespace: Herps.API

# Configures the endpoint
config :api, Herps.API.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CNUJ6e7IBoavuuh7HwwsaLtdjJuwLx4Ut7gbeqiP4cqlUcMzSVe7zkvTUFlj5yvz",
  render_errors: [view: Herps.API.ErrorView, accepts: ~w(json)],
  pubsub: [name: Herps.API.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :api, :generators,
  context_app: :core

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"