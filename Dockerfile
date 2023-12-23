FROM golang:1.20

WORKDIR /app

RUN mkdir -p ./assets
COPY assets/* assets/.

COPY go.mod ./

RUN mkdir -p ./main
COPY main/* ./main

WORKDIR ./main
RUN go get
RUN go install github.com/swaggo/swag/cmd/swag@latest
RUN swag init

WORKDIR /app
# Kompilieren Sie die Anwendung
RUN go build -o name ./main/.

EXPOSE 3000

ENTRYPOINT [ "/app/name" ]

#docker build . -t Container-name:latest
#docker run -p 3000:3000 Container-name:latest

