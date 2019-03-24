defmodule Mars.Repo.Migrations.ChangeCitusTableDistributed do
  use Ecto.Migration

  def change do
    execute "SET citus.shard_replication_factor = 1;"
    drop unique_index(:event, [:app_id, :message_id])
    execute "CREATE EXTENSION IF NOT EXISTS citus"
    execute "select create_distributed_table('event', 'message_id')"
  end
end
