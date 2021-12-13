defmodule ApiGithubWeb.RepositoriesView do
  use ApiGithubWeb, :view

  def render("repositories.json", %{repositories: repos}) do
    %{repositories: repos}
  end
end
