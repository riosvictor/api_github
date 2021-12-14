defmodule ApiGithub.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :password_hash, :string

      timestamps()
    end
  end
end
