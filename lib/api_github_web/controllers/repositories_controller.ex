defmodule ApiGithubWeb.RepositoriesController do
  use ApiGithubWeb, :controller

  alias ApiGithub.Repository
  alias ApiGithubWeb.FallbackController

  action_fallback FallbackController

  def get(conn, %{"username" => username}) do
    with {:ok, [%Repository{} | _rest] = repositories} <-
           ApiGithub.get_repo_by_username(username) do
      conn
      |> put_status(:ok)
      |> render("repositories.json", repositories: repositories)
    end
  end
end
