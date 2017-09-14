
export WORK_DIR = $(shell pwd)/

dummy:
	@echo $(WORK_DIR)

docker-build:
	docker build --force-rm -t alpine-mirror .

docker-build-support:
	docker build --force-rm -f Dockerfile.rsyncd -t alpine-mirror-rsyncd .
	#docker build --force-rm -f Dockerfile.alpine-mirror -t alpine-local .
	#docker build --force-rm -f Dockerfile.alpine-mirror-v3.5 -t alpine-local-35 .

docker-run:
	docker run --name alpine-mirror \
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

docker-run-rsyncd:
	docker run --name alpine-mirror-rsyncd \
		--restart always \
		--cap-drop=all \
		--volumes-from alpine-mirror \
		-p 873:8873 \
		-t alpine-mirror-rsyncd

docker-update:
	git pull; \
	docker rm -f alpine-mirror; \
	make docker-build; \
	make docker-run; \
	docker logs -f alpine-mirror

docker-stop:
	docker stop alpine-mirror

docker-logs:
	docker logs -f alpine-mirror

browse-repo:
	x-www-browser http://127.0.0.1:3143/
