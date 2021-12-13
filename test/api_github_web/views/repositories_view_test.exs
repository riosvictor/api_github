defmodule ApiGithubWeb.RepositoriesViewTest do
  use ApiGithubWeb.ConnCase, async: true

  import Phoenix.View

  alias ApiGithubWeb.RepositoriesView
  alias ApiGithub.Repositorie

  test "renders repositories.json" do
    repositories = [
      %Repositorie{
        id: "eed5f246-1475-4b31-9822-e123d165f518",
        description: "Rua de cima, 89",
        stargazers_count: 27,
        html_url: "sandro@banana.com",
        name: "Sandro Souza"
      }
    ]

    response = render(RepositoriesView, "repositories.json", repositories: repositories)

    assert %{
             repositories: [
               %ApiGithub.Repositorie{
                 description: "Rua de cima, 89",
                 html_url: "sandro@banana.com",
                 id: "eed5f246-1475-4b31-9822-e123d165f518",
                 name: "Sandro Souza",
                 stargazers_count: 27
               }
             ]
           } = response
  end
end
