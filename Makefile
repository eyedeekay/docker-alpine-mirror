
export WORK_DIR = $(shell pwd)

dummy:

docker-build:
	docker build --force-rm -t alpine-mirror .

docker-run:
	docker run -d \
		--name alpine-mirror \
		-p 3143:3143 \
		-v $(WORK_DIR)apkmirror:/home/apkmirror/www/htdocs/alpine \
		-t alpine-mirror
