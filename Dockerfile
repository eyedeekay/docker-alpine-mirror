FROM alpine:3.6
RUN apk update
RUN apk add darkhttpd rsync
ADD hourly.alpine-mirror /etc/periodic/hourly/alpine-mirror
RUN chmod +x /etc/periodic/hourly/alpine-mirror
RUN echo "#! /bin/sh" > /usr/bin/init
RUN echo "darkhttpd /home/apkmirror/www/htdocs/ --port 3143 1>log 2>err &" >> /usr/bin/init
RUN echo "while true; do" >> /usr/bin/init
RUN echo "    /etc/periodic/hourly/alpine-mirror" >> /usr/bin/init
RUN echo "    tail log err" >> /usr/bin/init
RUN echo "    sleep 1h" >> /usr/bin/init
RUN echo "done" >> /usr/bin/init
RUN chmod +x /usr/bin/init
RUN adduser -h /home/apkmirror -D apkmirror
WORKDIR /home/apkmirror/
RUN mkdir -p /home/apkmirror/www/htdocs/alpine
RUN chown -R apkmirror:apkmirror /home/apkmirror/www/htdocs/
VOLUME /home/apkmirror/www/htdocs/
USER apkmirror
CMD /usr/bin/init
