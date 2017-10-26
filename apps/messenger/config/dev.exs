use Mix.Config

config :messenger, Herps.Messenger.Mailer,
  adapter: Bamboo.LocalAdapter
