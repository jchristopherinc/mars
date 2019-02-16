defmodule MarsWeb.Grpc.EventGrpcController do
  use GRPC.Server, service: MarsWeb.GrpcService.MarsGrpc.Service

  alias Mars.EventEngine.EventCollector
  alias MarsWeb.GrpcService.EventResponse

  @spec collect_event(MarsWeb.GrpcService.EventRequest.t(), GRPC.Server.Stream.t()) ::
          EventResponse.t()
  def collect_event(request, _stream) do
    # Build event
    event = %{
      app_id: request.app_id,
      message_id: request.message_id,
      event: request.event,
      # TODO: Change it to request time. accept timestamp and use it as-is
      created_at: Timex.now()
    }

    EventCollector.enqueue(event)

    EventResponse.new(success: true)
  end
end
