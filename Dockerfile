# Based on Jean Khawand <jk@jeankhawand.com> Dockerfile

FROM rust:1.80.1-alpine3.20 AS builder
ARG ANKI_VERSION

RUN apk update && apk add --no-cache build-base protobuf && rm -rf /var/cache/apk/*
RUN cargo install --git https://github.com/ankitects/anki.git \
--tag ${ANKI_VERSION} \
--root /anki-server  \
anki-sync-server

FROM alpine:3.20.2

ENV SYNC_HOST=0.0.0.0
ENV SYNC_PORT=27701
ENV SYNC_BASE=/data
EXPOSE 27701

RUN mkdir /data
COPY --from=builder /anki-server/bin/anki-sync-server /usr/local/bin/anki-sync-server
RUN apk update && apk add --no-cache bash && rm -rf /var/cache/apk/*
CMD ["anki-sync-server"]
# This health check will work for Anki versions 24.08.x and newer.
# For older versions, it may incorrectly report an unhealthy status, which should not be the case.
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget -qO- http://localhost:${SYNC_PORT}/health || exit 1
