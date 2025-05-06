# pytorch_example (how to create and run custom dockers)

This dir serves as a simple example for how to use docker for machine learning.

You can find this source at `/srv/data/pytorch_example` in merl. If you want to
check it out, start by logging into merl, then change directory:
```(bash)
cd /srv/data/pytorch_example/
```

`/srv/data/pytorch_example` contains some files that are useful for building and running
your own custom docker. Building a docker from scratch is a tedious process, so instead we
modify an existing docker and add things to it that are required for a specific task.

If you like, you can copy this dir and use it as a template for your own dockers.


## Building the docker

`Dockerfile` contains the instructions for how to build the docker.
Check the contents of `Dockerfile` to see what is done during the build.

Check the contents of `build.sh` to see what the docker build command looks like.
To build the docker, do:

```(bash)
./build.sh
```
The build may take a few minutes.

After building, you can list the docker images by doing:
```(bash)
docker images
```

## Running the docker

There are two example scripts for how to run the docker.

`run_nvidia_smi.sh` is a simple test to show that the docker is actually using the host GPU.

`run_python_script.sh` is an example on how to mount a dir from the host to the docker, and then run
a python script that exists in the host dir.

Check each of those files to see the docker commands and options.

To run:
```(bash)
./run_nvidia_smi.sh
./run_python_script.sh
```

## Cleaning up

The run scripts will not create persistent containers, since we are using the option `--rm`
(removes the container directly after exit). But, if you like, you can remove the custom image
that was built by doing:

```(bash)
docker image rm pytorch_example:latest
```
