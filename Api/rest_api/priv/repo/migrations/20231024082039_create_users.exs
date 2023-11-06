defmodule RestApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :email, :string
      add :role, :string, default: "user"
      add :password, :string, default: "123456"
      add :team, :string, default: "team1"

      timestamps(type: :utc_datetime)
    end
  end
end
