defmodule ApiGithubWeb.RepositoriesViewTest do
  use ApiGithubWeb.ConnCase, async: true

  import Phoenix.View
  import ApiGithub.Factory

  alias ApiGithubWeb.RepositoriesView

  test "renders repositories.json" do
    repositories = build_list(1, :repository)

    response = render(RepositoriesView, "repositories.json", repositories: repositories)

    assert %{
             repositories: [
               %ApiGithub.Repository{
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
