# ---- Build ----
FROM golang:1.8 as builder
ENV GOGS_VERSION 0.11.19
WORKDIR /go/src/github.com/gogits/gogs
RUN curl -fsSL "https://github.com/gogits/gogs/archive/v${GOGS_VERSION}.tar.gz" \
    | tar -xz --strip-components=1

RUN CGO_ENABLED=0 make build
RUN mkdir /target && cp -R gogs public templates /target/

# ---- Final ----
FROM alpine:3.6
RUN apk add --no-cache git

ENV GOGS_CUSTOM /app/gogs
WORKDIR $GOGS_CUSTOM
COPY --from=builder /target/ .

ENV USER gogs
RUN mkdir repositories && \
    addgroup -S $USER && \
    adduser -S -G $USER $USER && \
    chown -R $USER: .
VOLUME repositories

CMD [ "./gogs", "web" ]
EXPOSE 3000
