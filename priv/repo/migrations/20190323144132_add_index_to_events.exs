defmodule Mars.Repo.Migrations.AddIndexToEvents do
  use Ecto.Migration

  # needed because, postgrex throws error when index is created as part of migration :(
  @disable_ddl_transaction true

  def change do
    # execute "CREATE INDEX CONCURRENTLY ON event(message_id)"

    create index("event", [:message_id])
  end
end
