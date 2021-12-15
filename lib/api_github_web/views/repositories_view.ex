defmodule ApiGithubWeb.RepositoriesView do
  use ApiGithubWeb, :view

  def render("repositories.json", %{repositories: repos, new_token: new_token}) do
    %{repositories: repos, new_token: new_token}
  end
end
