#!/bin/bash


protoc --version

# no go module, just clone
# git clone https://github.com/tronprotocol/java-tron -b GreatVoyage-v4.7.7
# git clone https://github.com/googleapis/googleapis


# Update golang package in all .proto files
find ./java-tron/protocol/src/main/protos -type f -name "*.proto" -exec sed -i '' \
-e 's|option go_package = "github.com/tronprotocol/grpc-gateway/core";|option go_package = "github.com/vieyang/go-tronprotocol/core";|g' \
-e 's|option go_package = "github.com/tronprotocol/grpc-gateway/api";|option go_package = "github.com/vieyang/go-tronprotocol/api";|g' {} +


protoc -I ./java-tron/protocol/src/main/protos -I googleapis --go_out ./ --go_opt paths=source_relative --go-grpc_out ./ --go-grpc_opt paths=source_relative --grpc-gateway_out ./ --grpc-gateway_opt logtostderr=true --grpc-gateway_opt paths=source_relative ./java-tron/protocol/src/main/protos/api/*.proto ./java-tron/protocol/src/main/protos/core/*.proto ./java-tron/protocol/src/main/protos/core/contract/*.proto

mv core/contract/*.pb.go core/ && rm -r core/contract


# rm -rf java-tron