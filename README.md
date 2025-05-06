# Talking Points

* About docker and how it works
* Examples of usage
* Why we use docker at FLOV

## About Docker, containers and how they work

### OS-level virtualization

Docker and podman use [OS-level virtualization](https://en.wikipedia.org/wiki/OS-level_virtualization) (as opposed to [hardware-level virtualization](https://en.wikipedia.org/wiki/Hardware_virtualization)) to run containers that share the host's kernel. They are most commonly used to run Linux distributions on top of a Linux host.
When running Linux dockers on MacOS and Windows a virtual machine is required. The exception being when running native Windows containers on Windows.

[chroot](https://en.wikipedia.org/wiki/Chroot) is an example of OS-level virtualization technology.
```(bash)
sudo debootstrap buster ./debian-buster
sudo mount --bind /dev ./debian-buster/dev
sudo mount --bind /proc ./debian-buster/proc
sudo mount --bind /sys ./debian-buster/sys
sudo cp /etc/resolv.conf ./debian-buster/etc/ # DNS
sudo chroot ./debian-buster /bin/bash
```


### OCI: runtime, images and distribution

Docker and podman are designed around [The Open Container Initiative (OCI)](https://en.wikipedia.org/wiki/Open_Container_Initiative), a Linux Foundation project, started in June 2015 by Docker, CoreOS, and the maintainers of appc to design open standards for operating system-level virtualization (containers).


#### Runtime

* runc (Docker default - written in Go)
* crun (Podman default - written in C)
* [nvidia container runtime](https://developer.nvidia.com/container-runtime) (to get access to GPU)

To check which runtime is used:
```(bash)
docker info | grep -i runtime
podman info --format '{{.Host.OCIRuntime}}'
```

#### Images

Example, creating your own (using debootstrap).

```(bash)
sudo debootstrap --arch=amd64 --variant=minbase buster ./debian-buster
sudo tar --numeric-owner -czf ../debian-buster.tar.gz .
docker import ../debian-buster.tar.gz custom-debian:buster
```

#### Distribution

Specifies the distribution methods for container images, ensuring that images can interact with repositories through standardized HTTP APIs.

In practice:
```(bash)
docker pull <image>
```

Official images typically from [https://hub.docker.com/](https://hub.docker.com/)

Local repositories can be created.


## Examples of docker usage

### Introduction to running containers

Hello world
```(bash)
docker run hello-world
docker ps -a        # list all containers, even non-running ones
docker rm <container-name>      # remove the container
docker run --rm hello-world     # run and remove container directly afterwards
docker ps -a
```

Python
```(bash)
docker pull python:latest
docker run --rm python:latest   # seemingly nothing happens
docker run --rm python:latest cat /etc/os-release   # run a command
docker run --rm python:latest bash      # seemingly nothing happens again
docker run --rm -it python:latest bash      # run command interactively
# create script on host and run it from the docker by mounting a dir on the host
echo 'print("Hello world")' > /tmp/hello-world.py
docker run \
    --rm \
    -v /tmp/:/srv/ \
    python:latest \
    python /srv/hello-world.py
```

pytorch with GPU (using nvidia container runtime)
```(bash)
docker run \
    --rm \
    --gpus all \
    -v /srv/data/pytorch_example/:/workspace \
    pytorch/pytorch:2.6.0-cuda12.4-cudnn9-runtime \
    python ./torch_example.py
```

Nginx (server)
```(bash)
docker run --rm nginx:latest
docker run -d --name nginx-server nginx:latest # run in background and name container
docker ps
docker stop nginx-server # stop container
docker start nginx-server # since container exists with a config, we can just start it
docker logs     # check logs
docker inspect nginx-server     # container configuration
```

### custom webapp (flask)

Check out subdir /custom-webapp

* Custom image based on official python image.


### drupal with sql using 'docker compose'

Check out subdir /drupal-with-sql

* only official images, no Dockerfile
* internal network created automatically

### Dockers in production

* publishing - firewall concerns

### Podman vs Docker

* user privilege
    * podman run as user
        * container storage in home dir
    * docker run as root (unless rootless)
        * container storage system wide


### Protecting secret data (passwords) using secrets

[docker secrets](https://docs.docker.com/engine/swarm/secrets/)


## Why we use dockers at FLOV

* No dependency conflicts between applications running on the same host (custom distro for each app)
* Minimal maintenance required between OS upgrades
