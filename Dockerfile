FROM golang:1.22 AS builder

WORKDIR /builder

COPY . .

RUN go build -o ./bin/kong-plugin-golang-demo ./...

FROM kong:3.6.1

COPY --from=builder /builder/bin/* /usr/local/share/lua/5.1/kong/plugins/

USER kong
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8001 8443 8444

STOPSIGNAL SIGQUIT
HEALTHCHECK --interval=10s --timeout=10s --retries=3 CMD kong health

CMD ["kong", "docker-start"]
