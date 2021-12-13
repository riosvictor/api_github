defmodule ApiGithub.Github.Client do
  use Tesla

  alias ApiGithub.{Error, Repositorie}
  alias Tesla.Env

  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]
  plug Tesla.Middleware.JSON

  @repo_url "https://api.github.com/"

  def get_user_repos(url \\ @repo_url, username) do
    "#{url}users/#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 404, body: _body}}) do
    {:error, Error.build(:not_found, "User not found")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    list =
      body
      |> Enum.map(fn repo ->
        %Repositorie{
          id: repo["id"],
          name: repo["name"],
          html_url: repo["html_url"],
          description: repo["description"],
          stargazers_count: repo["stargazers_count"]
        }
      end)

    {:ok, list}
  end
end
