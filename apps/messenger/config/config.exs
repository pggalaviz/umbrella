use Mix.Config

config :messenger,
  namespace: Herps.Messenger

import_config "#{Mix.env}.exs"
