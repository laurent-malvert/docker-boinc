# BOINC Dockerfiles

This project provides {{Dockerfile}}s to build docker containers
allowing you to run BOINC in an isolated environment on your machine
or in a cluster, and to control it.

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

## Build

    docker -t boinc boinc
    docker -t boinccmd boincmd

## Usage

### Starting the `boinc` BOINC Client

    # start the boinc-client, allowing connections from any host
    docker run                 \
    	   --name boinc-client \
	   -d                  \
	   boinc/boinc --allow_remote_gui_rpc

### Controlling the BOINC Client with `boinccmd`

Issue commands of the form:

    docker run                              \
    	   --rm                             \
	   --link boinc-client:boinc-client \
	   boinc/boinccmd                   \
	       --host boinc-client          \
	       [<BOINCCMD_ARGS>]

#### Examples

    # get current state
    docker run                              \
    	   --rm                             \
	   --link boinc-client:boinc-client \
	   boinc/boinccmd                   \
	       --host boinc-client          \
	       --get_state

    # join account manager
    docker run                              \
    	   --rm                             \
	   --link boinc-client:boinc-client \
	   boinc/boinccmd                   \
	       --host boinc-client          \
               --join_acct_mgr <URL> <LOGIN> <PASS>

## Possible Improvements ?

 * Use volumes to grab startup config.
 * Use volumes to persist work data and config between execution.
 * Provide some preset startup scripts.
 * `boinccmd` image unnecessarily installs the whole of boinc, when it
   only requires parts of it.
