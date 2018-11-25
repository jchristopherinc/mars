defmodule MarsWeb.TimeHelper do
  use Timex

  @moduledoc """
  Time Utils for MARS (but runs on 🌏 time though)
  """

  @doc """
  Parses time and returns value in MARS format - `%H:%I:%M:%S:%L - %d / %b / %Y`
  """
  def parse_time(time) do
    parsed_time = Timex.parse!(time, "{ISO:Extended:Z}")

    mars_formatted_time(parsed_time)
  end

  @doc """
  Formats time value into MARS format - `%H:%I:%M:%S:%L - %d / %b / %Y`
  """
  def mars_formatted_time(parsed_time) do
    {:ok, formatted_time} =
      parsed_time
      |> Timex.format("%H:%I:%M:%S:%L - %d / %b / %Y", :strftime)

    formatted_time
  end
end
