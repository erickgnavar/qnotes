# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :qnotes,
  ecto_repos: [Qnotes.Repo]

# Configures the endpoint
config :qnotes, QnotesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qb/QB1Hm2OYsfEpBCTU3vbwPoq3o1hCpvI2pg3FWjdoHcHQLIrcNum/hZzHfU01B",
  render_errors: [view: QnotesWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Qnotes.PubSub,
  live_view: [signing_salt: "hAXHoV6a"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
