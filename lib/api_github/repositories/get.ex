defmodule ApiGithub.Repositories.Get do
  def by_username(username) do
    client().get_user_repos(username)
  end

  defp client() do
    :api_github
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:github_adapter)
  end
end
