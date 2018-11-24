defmodule MarsWeb.TimeHelper do
  use Timex
  
  def parse_time(time) do
    parsed_time = Timex.parse!(time, "{ISO:Extended:Z}")

    {:ok, formatted_time} =
      parsed_time
      |> Timex.format("%H:%I:%M:%S:%L - %d / %b / %Y", :strftime)

    formatted_time
  end
end