NAME=teamspeak
VERSION=$(shell cat VERSION)

build:
	docker build -t solidnerd/${NAME}:${VERSION} \
	--build-arg BUILD_DATE="$(shell date +"%Y-%m-%d %H:%M:%S%:z")" \
	--build-arg VCS_REF=$(shell git rev-parse --short HEAD) \
	.

shell: build
	docker run -it --rm  ${NAME}:${VERSION} sh

release:
	docker build -t solidnerd/${NAME}:${VERSION} \
	--build-arg BUILD_DATE="$(shell date +"%Y-%m-%d %H:%M:%S%:z")" \
	--build-arg VCS_REF=$(shell git rev-parse --short HEAD) \
	.
	docker push solidnerd/${NAME}:${VERSION}

test: build
	docker run -e TS3SERVER_LICENSE=accept --rm -it -p "9987:9987/udp" ${NAME}:${VERSION}
