FROM anapsix/alpine-java:8_jdk

# SSL support for wget
RUN apk --no-cache add openssl

# boot-clj
RUN apk upgrade --update \
  && apk add --update \
  && wget -O /usr/bin/boot https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh \
  && chmod +x /usr/bin/boot

ADD runboot /usr/bin/runboot
