defmodule Mars.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:event) do
      add :message_id, :string
      add :app_id, :string
      add :event, :string
      add :created_at, :utc_datetime

      timestamps()
    end

  end
end
