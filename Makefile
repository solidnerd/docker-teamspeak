NAME=teamspeak
VERSION=3.0.12.3

build:
	docker build -t ${NAME}:${VERSION} .

shell: build
	docker run -it --rm  ${NAME}:${VERSION} sh

release: 
	docker build -t solidnerd/${NAME}:${VERSION} .

test: build
	docker run --net="teamspeak_nw" --env-file=.envfile --rm -it -P ${NAME}:${VERSION}
