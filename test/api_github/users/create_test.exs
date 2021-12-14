defmodule ApiGithub.Users.CreateTest do
  use ApiGithub.DataCase, async: true

  import ApiGithub.Factory

  alias ApiGithub.{Error, User}
  alias ApiGithub.Users.Create

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      response = Create.call(params)

      assert {:ok, %User{id: _id, password: "123456"}} = response
    end

    test "when there are invalid params, returns an error" do
      wrong_params = build(:user_params, %{"password" => "123"})

      response = Create.call(wrong_params)

      expected_response = %{
        password: ["should be at least 6 character(s)"]
      }

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
