FROM golang:1.23.2 AS builder

WORKDIR /app

COPY . .
RUN go mod tidy

WORKDIR /app/main
RUN go install github.com/swaggo/swag/cmd/swag@latest && swag init

WORKDIR /app
RUN go build -o rest-api ./main/.

FROM scratch
COPY --from=builder /app/rest-api /app/
COPY --from=builder /app/docs /app/

EXPOSE 3000

ENTRYPOINT [ "/app/rest-api" ]