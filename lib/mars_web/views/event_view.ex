defmodule MarsWeb.EventView do
  use MarsWeb, :view
  use Timex

  @doc """
  Returns a static success response whenever a event is created.
  """
  def render("create_event.json", _) do
    %{
      success: true
    }
  end

  def parse_time(time) do
    parsed_time = Timex.parse!(time, "{ISO:Extended:Z}")

    {:ok, formatted_time} = parsed_time 
    |> Timex.format("%d / %b / %Y - %H:%I:%M:%S:%L", :strftime)

    formatted_time
  end

  def parse_event(event) do
    String.replace(event, "_", " ")
  end
end
