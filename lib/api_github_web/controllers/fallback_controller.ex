defmodule ApiGithubWeb.FallbackController do
  use ApiGithubWeb, :controller

  alias ApiGithubWeb.ErrorView

  def call(conn, {:error, %{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
