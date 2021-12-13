defmodule ApiGithub do
  @moduledoc """
  ApiGithub keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias ApiGithub.Repositories.Get, as: ReposGet

  defdelegate get_repo_by_username(username), to: ReposGet, as: :by_username
end
