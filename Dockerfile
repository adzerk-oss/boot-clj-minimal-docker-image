FROM anapsix/alpine-java:8_jdk

# SSL support for wget
RUN apk --no-cache add openssl

# boot-clj
RUN apk upgrade --update \
  && apk add --update \
  && wget -O /usr/bin/boot https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh \
  && chmod +x /usr/bin/boot
RUN apk add gettext libintl

ADD entrypoint.sh /entrypoint.sh
ADD bootstrap.sh /bootstrap.sh

ENTRYPOINT ["/entrypoint.sh"]
