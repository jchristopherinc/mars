defmodule Mars.EventEngine.EventStateContainer do
  use Agent

  @moduledoc """
    A GenServer that acts as a very simple single Erlang term store
    used in conjuncion with another GenServer.
  """
  def start_link do
    Agent.start_link(fn -> %{} end, name: :statecontainer)
  end

  @doc """
    Gets a value from the `bucket` by `key`.
  """
  def get(key) do
    Agent.get(:statecontainer, &Map.get(&1, key))
  end

  @doc """
    Puts the `value` for the given `key` in the `bucket`.
  """
  def put(key, value) do
    Agent.update(:statecontainer, &Map.put(&1, key, value))
  end

  @doc """
  Deletes `key` from `bucket`.
  Returns the current value of `key`, if `key` exists.
  """
  def delete(key) do
    Agent.get_and_update(:statecontainer, &Map.pop(&1, key))
  end
end