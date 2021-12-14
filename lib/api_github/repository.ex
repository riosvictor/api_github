defmodule ApiGithub.Repository do
  use Ecto.Schema

  @derive {Jason.Encoder, only: [:id, :name, :description, :html_url, :stargazers_count]}

  schema "repositories" do
    field :name, :string
    field :description, :string
    field :html_url, :string
    field :stargazers_count, :integer
  end
end
