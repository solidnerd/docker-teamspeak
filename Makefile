NAME=teamspeak
VERSION=3.0.12.4

build:
	docker build -t ${NAME}:${VERSION} .

shell: build
	docker run -it --rm  ${NAME}:${VERSION} sh

release:
	docker build -t solidnerd/${NAME}:${VERSION} .

test: build
	docker run  --rm -it -p "9987:9987/udp" ${NAME}:${VERSION}
