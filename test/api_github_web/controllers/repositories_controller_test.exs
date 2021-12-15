defmodule ApiGithubWeb.RepositoriesControllerTest do
  use ApiGithubWeb.ConnCase, async: true

  import Mox
  import ApiGithub.Factory

  alias ApiGithub.Github.ClientMock
  alias ApiGithub.Repository
  alias ApiGithubWeb.Auth.Guardian

  describe "get/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user, %{}, ttl: {1, :minute})
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "when there is a username valid, return a repo list", %{conn: conn} do
      username = "danilo-vieira"

      expect(ClientMock, :get_user_repos, fn _item ->
        {:ok,
         [
           %Repository{
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

      assert %{
               "repositories" => [
                 %{
                   "description" => "short description",
                   "html_url" => "www.aquela.url.mesmo.com",
                   "id" => 12_314_123_213,
                   "name" => "John Lennon",
                   "stargazers_count" => 11
                 }
               ],
               "new_token" => _token
             } = response
    end
  end
end
