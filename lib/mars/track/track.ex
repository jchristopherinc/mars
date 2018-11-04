defmodule Mars.Track do
  @moduledoc """
  The Track context.
  """

  import Ecto.Query, warn: false
  alias Mars.Repo

  alias Mars.Track.Event

  @doc """
  Returns the list of event.

  ## Examples

      iex> list_event()
      [%Event{}, ...]

  """
  def list_event do
    Repo.all(Event)
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{source: %Event{}}

  """
  def change_event(%Event{} = event) do
    Event.changeset(event, %{})
  end

  @doc """
  Pushes events from EventStore.ex to DB for persistence
  """
  def upsert_event(event) do

    #Raw SQL prepared statement for Upsert
    query_upsert_event = """
      INSERT INTO 
      event(app_id, message_id, event, created_at, inserted_at, updated_at) 
      VALUES ($1::integer, $2::integer, $3::JSONB, $4, $5, $6) 
      ON CONFLICT (app_id, message_id) 

      DO 

      UPDATE
      SET event = event.event || excluded.event, updated_at = excluded.updated_at
    """

    #to have a common time stamp
    current_timestamp = Timex.now()

    #upsert event into the DB
    Ecto.Adapters.SQL.query!(Repo, query_upsert_event, [
      event.app_id, 
      event.message_id, 
      Jason.encode!(event.event_map),
      current_timestamp, #created at
      current_timestamp, #inserted at
      current_timestamp #updated at
    ])
  end
end
