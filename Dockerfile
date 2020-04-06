FROM golang:1.14-alpine

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

CMD ["./main"]
