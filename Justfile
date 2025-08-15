work:
    run-pty % just watch % just caddy

watch:
    fd .janet | entr -r -s 'janet example/example.janet'

caddy:
    caddy reverse-proxy -i -f office.localhost -t 127.0.0.1:8000

compose:
    docker-compose -f example/compose.yaml up

decompose:
    docker-compose -f example/compose.yaml down

test:
    judge test -a
