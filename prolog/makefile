run: .build
	docker exec -it $$(docker run -i -d --mount type=bind,source=./app,target=/app plp-project:1.0 sleep 1d) bash

build:
	docker build -t plp-project:1.0 . && touch .build
