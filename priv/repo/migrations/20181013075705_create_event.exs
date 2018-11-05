defmodule Mars.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:event) do
      add :message_id, :string
      add :app_id, :string
      add :event, :jsonb
      add :created_at, :utc_datetime

      timestamps()
    end

    create unique_index(:event, [:app_id, :message_id])
  end
end
