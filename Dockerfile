FROM debian:jessie

MAINTAINER Laurent Malvert <laurent.malvert@gmail.com>

LABEL                                                                      \
    Vendor="Laurent Malvert"                                               \
    Description="A base container image for lightweight BOINC clients"     \
    Version="jessie_7.4.23"                                                \
    Boinc-Version="7.4.23"                                                 \
    Base-Version="debian:jessie"

# -- BOINC ---------------------------------------------------------------

ENV GOSU_VERSION 1.9
RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends boinc-client ca-certificates wget && rm -rf /var/lib/apt/lists/* \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apt-get purge -y --auto-remove wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE    \
    31416 \
    80    \
    443

WORKDIR /var/lib/boinc-client

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["boinc"]
