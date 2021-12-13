defmodule ApiGithub.Repositorie do
  use Ecto.Schema

  @derive {Jason.Encoder, only: [:id, :name, :description, :html_url, :stargazers_count]}

  schema "repositorie" do
    field :name, :string
    field :description, :string
    field :html_url, :string
    field :stargazers_count, :integer
  end
end
