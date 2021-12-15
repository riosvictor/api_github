defmodule ApiGithubWeb.RepositoriesController do
  use ApiGithubWeb, :controller

  alias ApiGithub.Repository
  alias ApiGithubWeb.FallbackController
  alias ApiGithubWeb.Auth.Guardian

  action_fallback FallbackController

  def get(conn, %{"username" => username}) do
    with {:ok, [%Repository{} | _rest] = repositories} <-
           ApiGithub.get_repo_by_username(username),
         {:ok, new_token} <- Guardian.get_new_token(conn) do
      conn
      |> put_status(:ok)
      |> render("repositories.json", repositories: repositories, new_token: new_token)
    end
  end
end
