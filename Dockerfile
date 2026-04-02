FROM golang:1.26 AS builder

WORKDIR /go/src/github.com/hunterlong/ethexporter
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /ethexporter .

FROM gcr.io/distroless/static-debian13

COPY --from=builder /ethexporter /ethexporter

ENV GETH=https://mainnet.infura.io
ENV PORT=9015

EXPOSE 9015

ENTRYPOINT ["/ethexporter"]
