# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :piccadilly,
  ecto_repos: [Piccadilly.Repo]

# Configures the endpoint
config :piccadilly, PiccadillyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "j2xNLs08YLla3cpcB9mCPwf/QX3sxQl/OAT3FpQVMkz/HjmmN1mBX0FYZ5hYg/h4",
  render_errors: [view: PiccadillyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Piccadilly.PubSub,
  live_view: [signing_salt: "OsXZ4oO2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
