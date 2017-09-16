use Mix.Config

# Configure your database
config :core, Herps.Core.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "herps_dev",
  hostname: "localhost",
  pool_size: 10
