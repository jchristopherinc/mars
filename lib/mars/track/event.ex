defmodule Mars.Track.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
  Events Table schema
  """

  @primary_key false
  schema "event" do
    field :app_id, :string
    field :created_at, :utc_datetime
    field :event, :map
    field :message_id, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:message_id, :app_id, :event, :created_at])
    |> validate_required([:message_id, :app_id, :event, :created_at])
  end
end
