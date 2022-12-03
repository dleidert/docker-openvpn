# OpenVPN Docker Container

The aim of this project is to have a small Debian stable-based Docker container
providing an OpenVPN server with the same limitations and settings the
`openvpn-server@.service` uses.

The container does not include a CA environment. The necessary CA is maintained
elsewhere. The configuration and the certificates and files, necessary to run
the server, are expected to be copied into the configuration directory via a
bind mount ot named volume (see [`docker-compose.yml`](docker-compose.yml)).

## Structure

The project's [`Dockerfile`](Dockerfile) contains the instructions to build the
image, while the [`docker-compose.yml`](docker-compose.yml) file contains a few
[build](docker-compose.yml#L34) instructions, but mainly the directives to run
the docker container.

The `tun` device is not created, but [mapped](docker-compose.yml#L18-L19) into
the container!

The configuration of sysctl is also done via
[`docker-compose.yml`](docker-compose.yml#L20-L23).

The file `ta.key` must be created. If this file does not exist when starting
the container, it will be created, but requires `/etc/openvpn` to be mounted
*read-write*. For normal operations, though, this directory should be
read-only.

## Docker Hub

The image can be found at <https://hub.docker.com/r/dleidert/docker-openvpn-server>.
