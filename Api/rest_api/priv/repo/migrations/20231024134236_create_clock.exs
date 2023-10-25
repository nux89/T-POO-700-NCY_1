defmodule RestApi.Repo.Migrations.CreateClock do
  use Ecto.Migration

  def change do
    create table(:clock, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :time, :naive_datetime
      add :status, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:clock, [:user_id])
  end
end
