run: .build
	docker run -it --mount type=bind,source=./app,target=/app plp-project:1.0

build:
	docker build -t plp-project:1.0 . && touch .build
