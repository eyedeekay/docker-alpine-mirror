
export WORK_DIR = $(shell pwd)

dummy:

docker-build:
	docker build --force-rm -t alpine-mirror .

docker-run:
	docker run -d \
		--cap-drop=all \
		--name alpine-mirror \
		-p 3143:3143 \
		-v $(WORK_DIR)apkmirror:/home/apkmirror/www/htdocs/alpine \
		-t alpine-mirror

docker-update:
	git pull; \
	docker rm -f alpine-mirror; \
	docker rmi -f alpine-mirror; \
	docker system prune -f; \
	make docker-build; \
	make docker-run; \
	docker logs -f alpine-mirror
