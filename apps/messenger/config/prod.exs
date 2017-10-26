use Mix.Config

config :messenger, Herps.Messenger.Mailer,
  adapter: Bamboo.SendGridAdapter,
  api_key: System.get_env("SENDGRID_API_KEY")
