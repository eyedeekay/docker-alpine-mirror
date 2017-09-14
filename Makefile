
export WORK_DIR = $(shell pwd)/

dummy:
	@echo $(WORK_DIR)

docker-build:
	docker build --force-rm -t alpine-mirror .

docker-run:
	docker run -d \
		--name alpine-mirror \
		--restart always \
		--cap-drop=all \
		--cap-add=setuid \
		--cap-add=setgid \
		--cap-add=chown \
		--cap-add=dac_override \
		--cap-add=fowner \
		-p 3143:3143 \
		-v $(WORK_DIR)apkmirror:/home/apkmirror/www/htdocs/alpine \
		-t alpine-mirror

docker-update:
	git pull; \
	docker rm -f alpine-mirror; \
	make docker-build; \
	make docker-run; \
	docker logs -f alpine-mirror
