defmodule Mars.Scheduler do
  use Quantum.Scheduler,
    otp_app: :mars

  @moduledoc """
  Scheduler to delete old events from MARS
  """
end
