defmodule ApiGithub.Github.Client do
  use Tesla

  alias ApiGithub.{Error, Repositorie}
  alias Tesla.Env

  plug Tesla.Middleware.BaseUrl, "https://api.github.com/"
  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]
  plug Tesla.Middleware.JSON

  def user_repos(username) do
    ("users/" <> username <> "/repos")
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 403, body: _body}}) do
    {:error, Error.build(:forbidden, "Request forbidden")}
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
