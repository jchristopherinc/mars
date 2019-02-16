defmodule MarsWeb.EventGrpcController do
  use GRPC.Server, service: MarsWeb.GrpcService.MarsGrpc.Service

  alias MarsWeb.GrpcService.EventResponse

  @spec collect_event(MarsWeb.GrpcService.EventRequest.t(), GRPC.Server.Stream.t()) ::
          EventResponse.t()
  def collect_event(request, _stream) do
    EventResponse.new(success: true)
  end
end
