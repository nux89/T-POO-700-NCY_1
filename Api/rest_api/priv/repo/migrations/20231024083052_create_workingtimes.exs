defmodule RestApi.Repo.Migrations.CreateWorkingtimes do
  use Ecto.Migration

  def change do
    create table(:workingtimes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :start, :naive_datetime
      add :end, :naive_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
