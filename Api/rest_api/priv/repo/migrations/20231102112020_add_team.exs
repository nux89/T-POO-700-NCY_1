defmodule RestApi.Repo.Migrations.AddTeam do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :team, :string, default: "AUCUN"
    end
  end
end
