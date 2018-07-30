# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :personal_site,
  ecto_repos: [PersonalSite.Repo]

# Configures the endpoint
config :personal_site, PersonalSiteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5i9LwkRYbcrYfgsO6HzwyPLoBO1DWLbhlNjKFsqG9qCfhAqA7D1K7pubvgjY95Qv",
  render_errors: [view: PersonalSiteWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PersonalSite.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
