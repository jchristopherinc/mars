defmodule MarsWeb.Grpc.Endpoint do
  use GRPC.Endpoint

  intercept GRPC.Logger.Server
  run(MarsWeb.Grpc.EventGrpcController)
end
