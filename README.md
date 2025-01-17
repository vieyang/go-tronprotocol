# Golang Tron Protocol lib

```shell
# import go-tronprotocol
go get github.com/vieyang/go-tronprotocol
```

usage:

```go
package hello

import (
	"context"
	"encoding/hex"
	"fmt"

	"github.com/vieyang/go-tronprotocol/api"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func Hi() {
	target := "grpc.trongrid.io:50051"

	conn, _ := grpc.NewClient(target, grpc.WithTransportCredentials(insecure.NewCredentials()))
	defer conn.Close()

	wc := api.NewWalletClient(conn)
	block, _ := wc.GetBlock(context.Background(), &api.BlockReq{Detail: false})
	fmt.Println(block.BlockHeader.RawData.Number, hex.EncodeToString(block.Blockid))
	return
}
```

grpcurl cmd:

```shell
# grpcurl test
grpcurl -plaintext \
  -import-path java-tron/protocol/src/main/protos/ \
  -import-path googleapis \
  -proto java-tron/protocol/src/main/protos/api/api.proto \
  -d '{"id_or_num":"1","detail":false}' \
  grpc.trongrid.io:50051 protocol.Wallet/GetBlock
```