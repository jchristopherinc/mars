defmodule MarsWeb.GrpcService.EventRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          app_id: String.t(),
          message_id: String.t(),
          event: String.t(),
          created_at: String.t()
        }
  defstruct [:app_id, :message_id, :event, :created_at]

  field :app_id, 1, type: :string
  field :message_id, 2, type: :string
  field :event, 3, type: :string
  field :created_at, 4, type: :string
end

defmodule MarsWeb.GrpcService.EventResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          success: boolean
        }
  defstruct [:success]

  field :success, 1, type: :bool
end

defmodule MarsWeb.GrpcService.MarsGrpc.Service do
  @moduledoc false
  use GRPC.Service, name: "MarsWeb.GrpcService.MarsGrpc"

  rpc :collectEvent, MarsWeb.GrpcService.EventRequest, MarsWeb.GrpcService.EventResponse
end

defmodule MarsWeb.GrpcService.MarsGrpc.Stub do
  @moduledoc false
  use GRPC.Stub, service: MarsWeb.GrpcService.MarsGrpc.Service
end
