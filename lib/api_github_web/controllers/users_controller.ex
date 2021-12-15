defmodule ApiGithubWeb.UsersController do
  use ApiGithubWeb, :controller

  alias ApiGithub.User
  alias ApiGithubWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- ApiGithub.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user, %{}, ttl: {1, :minute}) do
      conn
      |> put_status(:created)
      |> render("create.json", token: token, user: user)
    end
  end

  def login(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("login.json", token: token)
    end
  end
end
