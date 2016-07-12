# caddy


```
docker run \
  --volume $PWD/Caddyfile:/etc/caddy/Caddyfile \
  --volume $PWD/certs:/var/lib/caddy \
  --publish 80:80 \
  --publish 443:443 \
  docker-muenster/caddy:master
```
