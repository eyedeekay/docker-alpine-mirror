Docker Alpine Mirror
====================

This is a setup to configure an alpine mirror as a Docker container. It deviates
from the normal alpine mirror setup in that it does not involve cron. It simply
runs a script which starts the http server, redirects the logs to a file, and
starts an endless loop. Inside that loop, it starts rsync, waits for it to
finish+1hour, and starts the loop over again. This means that the container must
be stopped explicitly. The makefile has commands for convenience' sake, which
are

**make docker-build**

This will build the image with the tag alpine-mirror.

**make docker-run**

This will start the container with the name alpine-mirror.

**make docker-update**

This will remove the running container without deleting the volumes, update
the image, and re-start it.

**make docker-stop**

This will stop the container named alpine-mirror.

**make docker-logs**

Watch and follow the logs.

**make browse-repo**

Launch the repository page in x-www-browser.

Setup:

Simply clone this repository and change into the repo directory

        git clone https://github.com/eyedeekay/docker-alpine-mirror && \
            cd docker-alpine-mirror

Build the image with the pre-written command:

        make docker-build

and run it with the pre-written command:

        make docker-run

As more of it gets configured at build-time, these commands will be more
important.
