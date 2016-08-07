FROM alpine:3.4

RUN apk --no-cache add curl ca-certificates

# ARG CADDY_VERSION=0.9
ARG CADDY_FEATURES=filemanager,git,hugo,ipfilter,jwt,locale,mailout,minify,prometheus,ratelimit,realip,search,cloudflare,digitalocean,dnsimple,dyn,gandi,googlecloud,namecheap,rfc2136,route53,vultr

RUN ARCH=$(apk --print-arch | sed 's/x86_64/amd64/') \
  && curl -sfSL "https://caddyserver.com/download/build?os=linux&arch=$ARCH&features=$CADDY_FEATURES" \
    | tar -xz -C /tmp \
  && mv /tmp/caddy /usr/bin/caddy \
  && mkdir /var/www
  # FIXME! checksum

COPY ./Caddyfile /etc/caddy/
ENV CADDYPATH /var/lib/caddy

VOLUME /etc/caddy
VOLUME /var/lib/caddy
VOLUME /var/www

EXPOSE 80 443
CMD ["caddy", "-conf", "/etc/caddy/Caddyfile"]
