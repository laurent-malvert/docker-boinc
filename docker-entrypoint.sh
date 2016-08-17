#!/bin/bash
set -eo pipefail

# if command starts with an option, prepend boinc 
if [ "${1:0:1}" = '-' ]; then
	set -- boinc "$@"
fi

if [ "$1" = 'boinc' ]; then
    #fix permissions
    chown -R boinc:boinc /var/lib/boinc-client
    #reconfigure boinc just in case /var/lib/boinc-client is a volume and hasn't been used before
    dpkg-reconfigure boinc-client
    exec gosu boinc "$@"
else
    exec "$@"
fi

