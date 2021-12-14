defmodule ApiGithubWeb.UsersViewTest do
  use ApiGithubWeb.ConnCase, async: true

  import Phoenix.View
  import ApiGithub.Factory

  alias ApiGithub.User
  alias ApiGithubWeb.UsersView

  test "renders create.json" do
    user = build(:user)
    token = "qwe123"

    response = render(UsersView, "create.json", token: token, user: user)

    assert %{
             message: "User created!",
             token: "qwe123",
             user: %User{
               password: "123456"
             }
           } = response
  end

  test "renders login.json" do
    token = "qwe123"

    response = render(UsersView, "login.json", token: token)

    assert %{
             token: "qwe123"
           } = response
  end
end
