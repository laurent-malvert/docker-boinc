FROM debian:wheezy

MAINTAINER Laurent Malvert <laurent.malvert@gmail.com>

LABEL                                                                      \
    Vendor="Laurent Malvert"                                               \
    Description="A base container image for lightweight BOINC clients"     \
    Version="0.1"

# -- BOINC ---------------------------------------------------------------

RUN apt-get update &&                                    \
    DEBIAN_FRONTEND=noninteractive apt-get -q install -y \
		   boinc-client &&                       \
    apt-get clean &&                                     \
    rm -rf /var/lib/apt/lists/*

USER boinc

EXPOSE    \
    31416 \
    80    \
    443

WORKDIR /var/lib/boinc-client

ENTRYPOINT ["boinc"]
