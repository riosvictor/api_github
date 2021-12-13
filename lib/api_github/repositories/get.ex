defmodule ApiGithub.Repositories.Get do
  alias ApiGithub.Github.Client

  def by_username(username) do
    Client.user_repos(username)
  end
end
