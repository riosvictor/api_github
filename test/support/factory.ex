defmodule ApiGithub.Factory do
  use ExMachina.Ecto, repo: ApiGithub.Repo

  alias ApiGithub.{User, Repository}

  def user_params_factory do
    %{
      "password" => "123456"
    }
  end

  def user_factory do
    %User{
      password: "123456"
    }
  end

  def repository_factory do
    %Repository{
      id: "eed5f246-1475-4b31-9822-e123d165f518",
      description: "Rua de cima, 89",
      stargazers_count: 27,
      html_url: "sandro@banana.com",
      name: "Sandro Souza"
    }
  end
end
