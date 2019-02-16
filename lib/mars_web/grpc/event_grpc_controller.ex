defmodule MarsWeb.EventGrpcController do
  use GRPC.Server, service: MarsWeb.GrpcService.MarsGrpc.Service

  alias MarsWeb.GrpcService.EventResponse

  @spec collect_event(MarsWeb.GrpcService.EventRequest.t, GRPC.Server.Stream.t) :: MarsWeb.GrpcService.EventResponse.t
  def collect_event(request, _stream) do

    IO.puts request.app_id
    EventResponse.new(success: true)
  end
end