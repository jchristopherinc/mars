Command to generate Elixir stubs

Install protobuf 

```
mix escript.install hex protobuf
```

then,

```
protoc --elixir_out=plugins=grpc:/Users/christopher/Documents/mars/lib/mars_web/proto_ex  --plugin=protoc-gen-elixir=/Users/christopher/.mix/escripts/protoc-gen-elixir *.proto
```

replace path with yours.