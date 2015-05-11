FROM debian:jessie

MAINTAINER Laurent Malvert <laurent.malvert@gmail.com>

LABEL                                                                      \
    Vendor="Laurent Malvert"                                               \
    Description="A base container image for lightweight BOINC clients"     \
    Version="jessie_7.4.23"                                                \
    Boinc-Version="7.4.23"                                                 \
    Base-Version="debian:jessie"

# -- BOINC ---------------------------------------------------------------

RUN apt-get update &&                           \
    apt-get -q install -y boinc-client &&       \
    apt-get clean &&                            \
    rm -rf /var/lib/apt/lists/*

USER boinc

EXPOSE    \
    31416 \
    80    \
    443

WORKDIR /var/lib/boinc-client

ENTRYPOINT ["boinc"]
