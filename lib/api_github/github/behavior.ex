defmodule ApiGithub.Github.Behavior do
  alias ApiGithub.Error

  @callback get_user_repos(String.t()) :: {:ok, list()} | {:error, Error.t()}
end
