# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :github_analytics,
  ecto_repos: [GithubAnalytics.Repo]

# Configures the endpoint
config :github_analytics, GithubAnalyticsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gJqvrDEAR7iPn8LFAtSZdQvraYEueUWIESaQnHMnQ011G2ksiwsE6RqTPciT6Z77",
  render_errors: [view: GithubAnalyticsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GithubAnalytics.PubSub,
  live_view: [signing_salt: "rb/hs7rc"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :github_analytics, :github,
  graphql_api_url: "https://api.github.com/graphql"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
