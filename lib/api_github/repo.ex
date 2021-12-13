defmodule ApiGithub.Repo do
  use Ecto.Repo,
    otp_app: :api_github,
    adapter: Ecto.Adapters.Postgres
end
