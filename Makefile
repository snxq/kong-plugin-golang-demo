PLUGIN_NAME="kong-plugin-golang-demo"

run:
	docker run -d --name ${PLUGIN_NAME} \
		--network host \
		-v $(shell pwd)/config.yml:/kong/config.yml \
		-e "KONG_DATABASE=off" \
		-e "KONG_PLUGINSERVER_NAMES=${PLUGIN_NAME}" \
		-e "KONG_PLUGINS=${PLUGIN_NAME},bundled" \
		-e "KONG_DECLARATIVE_CONFIG=/kong/config.yml" \
		-e "KONG_PLUGINSERVER_WATCHDOG_START_CMD=/usr/local/share/lua/5.1/kong/plugins/${PLUGIN_NAME}" \
		-e "KONG_PLUGINSERVER_WATCHDOG_QUERY_CMD=/usr/local/share/lua/5.1/kong/plugins/${PLUGIN_NAME} -dump" \
		${PLUGIN_NAME}:latest

build:
	docker build -t ${PLUGIN_NAME}:latest .