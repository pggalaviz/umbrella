use Mix.Config

# Add all Core app repos.
config :core,
  namespace: Herps.Core,
  ecto_repos: [Herps.Core.Repo]

import_config "#{Mix.env}.exs"
