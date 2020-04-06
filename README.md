# DevOps > Projetos > Desafio Docker

## Descrição
Criar uma imagem com menos de 2MB que, quando executada, imprima Code.education Rocks!

## Resultado

https://hub.docker.com/repository/docker/diogodomanski/codeeducation

## Processo de resolução da atividade

Criar o arquivo `main.go`

```go
package main

import "fmt"

func main() {
  fmt.Println("Code.education Rocks!")
}

```

Criar o arquivo Dockerfile que realiza um processo multi stage de criação da imagem com apenas o executável do programa 
do arquivo `main.go`

```dockerfile
# Prepare and build main.go file
FROM golang:1.14-alpine as builder
WORKDIR /go/src/github.com/diogodomanski/codeeducation/
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .


# Create a new image from scratch and copy the executable file from builder image
FROM scratch
COPY --from=builder /go/src/github.com/diogodomanski/codeeducation/main .
CMD ["./main"]
```

Executar o comando

```
$ docker build --rm -t diogodomanski/codeeducation -t Dockerfile.prod .
```