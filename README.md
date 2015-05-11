## Description

Provides a `Dockerfile` to build a docker image allowing you to run a
BOINC client in a container.

For a dockerized `boinccmd` command to control this client, see the
`docker-boinccmd` repository.

## Why?

3 simple reasons:

 * I occasionally want to run BOINC on a machine that isn't mine, and
   it's either restricted or I don't want it to be visible or to leave
   stray data on the machine.

 * I didn't find a decent Dockerfile for this yet that I could use
   directly, and I figured others might like to have one.

 * It serves as a good test-bed for me to learn about docker for other
   purposes, as it could require me to use a lot of its features on
   the long run if it matures into something decent: volumes, data
   containers, links, compose, etc...

## Pull From DockerHub

    docker pull laurentmalvert/docker-boinc

## Build It Yourself

    docker -t boinc .

## Usage

### Starting the `boinc` BOINC Client

    # start the boinc-client, allowing connections from any host
    docker run          \
           --name boinc \
           -d           \
           laurentmalvert/docker-boinc --allow_remote_gui_rpc

### Remote Control

You can control your BOINC client using the `boinccmd` command-line
tool. See its [documentation][1] for usage details.

See also the `docker-boinccmd` repo for a dockerized version of
`boinccmd` and usage examples.

## Possible Improvements ?

 * Use volumes to grab startup config.
 * Use volumes to persist work data and config between execution.
 * Provide some preset startup scripts.




[1]: http://boinc.berkeley.edu/wiki/Boinccmd_tool
