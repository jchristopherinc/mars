defmodule Mars.EventCleanup do
  require Logger

  alias Mars.Track

  @moduledoc """
  Clean up junk events that are X weeks old
  """
  def start_cleanup do
    
    Logger.debug "____Starting old lifecycle events cleanup____"
    
    Track.delete_old_events
    
    Logger.debug "____Old lifecycle events cleanup completed____" 

  end
end
