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
	-p 24224:24224 \
	--name ${FLUENT_BIT_RUNTIME_NAME} \
	-v $(shell pwd)/env/docker/fluentbit:/etc/td-agent-bit \
	-v /data/log/fluent:/data/log/fluent \
	-v /data/lib/fluent:/data/lib/fluent \
	${FLUENT_BIT_RUNTIME_TAG}


start: \
	fluent-bit-runtime

stop: 
	docker stop ${FLUENT_BIT_RUNTIME_NAME}