FLUENT_BIT_RUNTIME_TAG='chirichidi/fluentbit'
FLUENT_BIT_RUNTIME_NAME='fluentbit'

build: \
	install-fluent-bit

install-fluent-bit:
	docker build \
        	--tag ${FLUENT_BIT_RUNTIME_TAG} \
        	./env/docker/fluentbit

fluent-bit-runtime:
	docker run -ti \
	--rm \
	-d \
	--network host \
	--name ${FLUENT_BIT_RUNTIME_NAME} \
	-v $(shell pwd)/env/docker/fluentbit:/etc/td-agent-bit \
	-v /data/lib/fluent:/data/lib/fluent \
	${FLUENT_BIT_RUNTIME_TAG}


start: \
	fluent-bit-runtime