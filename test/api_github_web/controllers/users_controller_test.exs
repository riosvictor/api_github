defmodule ApiGithubWeb.UsersControllerTest do
  use ApiGithubWeb.ConnCase, async: true

  import ApiGithub.Factory

  alias ApiGithub.User

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "id" => _uuid,
                 "password" => "123456"
               },
               "token" => _token
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = %{
        "password" => "qwe"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "password" => ["should be at least 6 character(s)"]
        }
      }

      assert expected_response == response
    end
  end

  describe "login/2" do
    test "when all params are valid, login the user", %{conn: conn} do
      create_params = build(:user_params)

      {:ok, %User{id: id, password: password}} = ApiGithub.create_user(create_params)

      params = %{
        id: id,
        password: password
      }

      response =
        conn
        |> post(Routes.users_path(conn, :login, params))
        |> json_response(:ok)

      assert %{
               "token" => _token
             } = response
    end

    test "when password is invalid, return an error", %{conn: conn} do
      create_params = build(:user_params)

      {:ok, %User{id: id}} = ApiGithub.create_user(create_params)

      params = %{
        id: id,
        password: "qweasd"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :login, params))
        |> json_response(:unauthorized)

      expected_response = %{"message" => "Please verify your credentials"}

      assert expected_response == response
    end

    test "when user not found by id, returns the error", %{conn: conn} do
      id = "eed5f246-1475-4b31-9822-e123d165f518"

      params = %{
        "id" => id,
        "password" => "qweasd"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :login, params))
        |> json_response(:not_found)

      expected_response = %{
        "message" => "User not found"
      }

      assert expected_response == response
    end

    test "when params is invalid, returns the error", %{conn: conn} do
      params = %{
        "id" => "eed5f246-1475-4b31-9822-e123d165f518"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :login, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => "Invalid or missing params"
      }

      assert expected_response == response
    end
  end
end
