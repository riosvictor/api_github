defmodule ApiGithubWeb.RepositoriesControllerTest do
  use ApiGithubWeb.ConnCase, async: true

  import Mox

  alias ApiGithub.Github.ClientMock
  alias ApiGithub.Repositorie

  describe "get/2" do
    test "when there is a username valid, return a repo list", %{conn: conn} do
      username = "danilo-vieira"

      expect(ClientMock, :get_user_repos, fn _item ->
        {:ok,
         [
           %Repositorie{
             description: "short description",
             html_url: "www.aquela.url.mesmo.com",
             id: 12_314_123_213,
             name: "John Lennon",
             stargazers_count: 11
           }
         ]}
      end)

      response =
        conn
        |> get(Routes.repositories_path(conn, :get, username))
        |> json_response(:ok)

      assert response == %{
               "repositories" => [
                 %{
                   "description" => "short description",
                   "html_url" => "www.aquela.url.mesmo.com",
                   "id" => 12_314_123_213,
                   "name" => "John Lennon",
                   "stargazers_count" => 11
                 }
               ]
             }
    end
  end
end
