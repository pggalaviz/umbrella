# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api,
  namespace: Herps.API,
  ecto_repos: []

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

# Configure Ueberauth
config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [default_scope: "emails profile plus.me"]}
  ]
config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# Config Guardian Authentication
config :api, Herps.API.Auth.Guardian,
  allowed_algos: ["HS512"],
  issuer: "_herps_",
  ttl: {10, :days},
  verify_issuer: true,
  secret_key: System.get_env("GUARDIAN_SECRET") ||
    "tlgTtW13As9IujrsCKa16DR0P0RD8WBjf7tHySyYqhkIzdBzU/c/VF5QqQ2LJiR2"

config :api, :generators,
  context_app: :core

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
