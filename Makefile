build:
	@docker build -t costume_world .

costume:
	@docker run --rm -v $$(pwd):/root/costume_world costume_world
