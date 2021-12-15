defmodule ApiGithubWeb.Auth.Guardian do
  use Guardian, otp_app: :api_github

  alias ApiGithub.{Error, User}
  alias ApiGithub.Users.Get, as: UserGet
  alias Plug.Conn

  @time_expiration_token {1, :minute}

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(%{"sub" => id}) do
    UserGet.by_id(id)
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.by_id(user_id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user, %{}, ttl: @time_expiration_token) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params")}

  def get_new_token(%Conn{} = conn) do
    token =
      conn
      |> Conn.get_req_header("authorization")
      |> hd()
      |> String.split()
      |> Enum.at(1)

    case refresh(token, ttl: @time_expiration_token) do
      {:error, _reason} -> {:error, Error.build(:bad_request, "Can't refresh token")}
      {:ok, _old_token, {new_token, _new_claims}} -> {:ok, new_token}
    end
  end
end
