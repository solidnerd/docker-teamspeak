NAME=teamspeak
VERSION=3.12.2

build:
	docker build -t ${NAME}:${VERSION} .

shell: build
	docker run -it --rm  ${NAME}:${VERSION} sh

test: build
	docker run --net="teamspeak_nw" --env-file=.envfile --rm -it -P ${NAME}:${VERSION}
