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

### Data persistence

To persist data add the `-v /path/to/host/directory:/var/lib/boinc-client` flag to the `docker run` command

### Configuration persistence

To use a persistent configuration you can either mount `/etc/boinc-client` as a volume or you can mount /var/lib/boinc-client
as a volume and add your configuration files to that directory. 

If you want to extract the default configuration files run the container without a volume and run `docker cp boinc:/etc/boinc-client /path/to/copy/to`

### Virtualbox

Some boinc projects use Virtualbox. Virtualbox isn't installed in this image due to size and techinical complications.

If you wish to use Virtualbox then first on the host machine you need to install Virtualbox and Virtualbox kernel module
See here https://www.virtualbox.org/wiki/Linux_Downloads for details of installing.

Next you need to install **the same version** of Virtualbox in your container, to do this creata a docker file which
contains the following:

```
FROM laurentmalvert/docker-boinc
RUN apt-get update \
    && apt-get -y install wget \
    && wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add - \
    && echo 'deb http://download.virtualbox.org/virtualbox/debian jessie contrib' >> /etc/apt/sources.list \
    && apt-get update && apt-get -y install virtualbox-5.1
```

Replacing `virtualbox-5.1` with whatever version you installed on your host machine.

You then need to add the `--device=/dev/vboxdrv` flag to your docker run command i.e. 
`/usr/bin/docker run --device=/dev/vboxdrv --name boinc yourimage --allow_remote_gui_rpc`

## Possible Improvements ?

 * Provide some preset startup scripts.

## Contributors

 * [laurent-malvert][2]
 * [rwky][3]



[1]: http://boinc.berkeley.edu/wiki/Boinccmd_tool
[2]: https://github.com/laurent-malvert
[3]: https://github.com/rwky
