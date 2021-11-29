build:
	@docker build -t bubblewrap .

bubblewrap:
	@docker run --rm -v $$(pwd):/root/bubblewrap bubblewrap
