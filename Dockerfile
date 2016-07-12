FROM alpine:3.4

RUN apk --no-cache add curl ca-certificates

ARG CADDY_VERSION=0.9-beta.2
RUN ARCH=$(apk --print-arch | sed 's/x86_64/amd64/') \
  && curl -sfSL "https://github.com/mholt/caddy/releases/download/v$CADDY_VERSION/caddy_linux_$ARCH.tar.gz" \
    | tar -xz -C /tmp \
  && mv /tmp/caddy_linux_$ARCH /usr/bin/caddy
  # FIXME! checksum

COPY ./Caddyfile /etc/caddy/
ENV CADDYPATH /var/lib/caddy

VOLUME /etc/caddy
VOLUME /var/lib/caddy

EXPOSE 80 443
CMD ["caddy", "-conf", "/etc/caddy/Caddyfile"]
