defmodule ApiGithubWeb.UsersView do
  use ApiGithubWeb, :view

  alias ApiGithub.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{
      message: "User created!",
      token: token,
      user: user
    }
  end

  def render("login.json", %{token: token}), do: %{token: token}
end
