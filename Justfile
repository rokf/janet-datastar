watch:
    fd .janet | entr -r -s 'janet example/example.janet'

compose:
    docker-compose -f example/compose.yaml up

decompose:
    docker-compose -f example/compose.yaml down

test:
    judge test -a
