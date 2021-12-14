defmodule ApiGithub.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias Plug.Conn
  alias ApiGithub.Github.Client
  alias ApiGithub.{Error, Repository}

  defp endpoint_url(port), do: "http://localhost:#{port}/"

  describe "user_repos/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid username, returns the repos info", %{bypass: bypass} do
      username = "riosvictor"

      url = endpoint_url(bypass.port)

      body = ~s([{
        "name": "John Lennon",
        "id": 12314123213,
        "description": "short description",
        "html_url": "www.aquela.url.mesmo.com",
        "stargazers_count": 11
      }])

      Bypass.expect(bypass, "GET", "users/#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_user_repos(url, username)

      expected_response =
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

      assert response == expected_response
    end

    test "when the username is invalid, returns an error", %{bypass: bypass} do
      username = "user_not_found"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "users/#{username}/repos", fn conn ->
        Conn.resp(conn, 404, "")
      end)

      response = Client.get_user_repos(url, username)

      expected_response = {:error, %Error{result: "User not found", status: :not_found}}

      assert response == expected_response
    end

    test "when there is a generic error, returns an error", %{bypass: bypass} do
      username = "00000000"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_user_repos(url, username)

      expected_response = {
        :error,
        %Error{
          result: :econnrefused,
          status: :bad_request
        }
      }

      assert response == expected_response
    end
  end
end
