# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :api_github,
  ecto_repos: [ApiGithub.Repo]

config :api_github, ApiGithub.Repositories.Get, github_adapter: ApiGithub.Github.Client

config :api_github, ApiGithub.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :api_github, ApiGithubWeb.Auth.Guardian,
  issuer: "api_github",
  secret_key: "mo7fshYCu0pll9MiyeY/NlN1jIca+KJAsY75ICsdnPWfkQVAOSrVvxSd8IsFE4Qd"

config :api_github, ApiGithubWeb.Auth.Pipeline,
  module: ApiGithubWeb.Auth.Guardian,
  error_handler: ApiGithubWeb.Auth.ErrorHandler

# Configures the endpoint
config :api_github, ApiGithubWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ApiGithubWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ApiGithub.PubSub,
  live_view: [signing_salt: "LUArwjuI"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :api_github, ApiGithub.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
