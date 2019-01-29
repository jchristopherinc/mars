defmodule Mars.Track do
  @moduledoc """
  The Track context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Adapters.SQL
  alias Mars.Repo
  alias Mars.Track.Event

  @doc """
  Pushes events from EventStore.ex to DB for persistence
  """
  def upsert_event(event) do
    # Raw SQL prepared statement for Upsert
    query_upsert_event = """
      INSERT INTO 
      event(app_id, message_id, event, created_at, inserted_at, updated_at) 
      VALUES ($1::integer, $2::integer, $3::JSONB, $4, $5, $6) 
      
      ON CONFLICT (app_id, message_id) 
      DO 

      UPDATE
      SET event = event.event::JSONB || excluded.event::JSONB, updated_at = excluded.updated_at
    """

    # to have a common time stamp
    current_timestamp = Timex.now()

    # upsert event into the DB
    SQL.query!(Repo, query_upsert_event, [
      event.app_id,
      event.message_id,
      event.event_map,
      # created at
      current_timestamp,
      # inserted at
      current_timestamp,
      # updated at
      current_timestamp
    ])
  end

  @doc """
  Given a message_id, return all the lifecycle events associated
  """
  def get_event_by_message_id(message_id) do
    Repo.get_by(Event, message_id: message_id)
  end

  @doc """
  Delete older messages and it's lifecycle events
  """
  def delete_old_events do
    from(e in Event, where: e.inserted_at < datetime_add(^NaiveDateTime.utc_now, -2, "week"))
    |> Repo.delete_all
  end
end
