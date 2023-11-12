defmodule RestApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :name, :string
      add :role, :string
      add :password, :string
      add :team, :string, default: "AUCUN"

      timestamps(type: :utc_datetime)
    end

    # Création d'une contrainte d'unicité sur le champ 'email'
    create unique_index(:users, [:email])
  end
end
