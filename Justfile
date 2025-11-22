work:
    run-pty % just watch % just caddy

watch:
    fd .janet | entr -r -s 'janet example/example.janet'

caddy:
    caddy reverse-proxy -i -f example.localhost -t 127.0.0.1:8000

test:
    judge test -a
