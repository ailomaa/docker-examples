#!/bin/bash

# With this command we run the custom docker that we've built
# and to show that we are communicating with the GPU
# on the host, we run the command nvidia-smi from inside
# the docker.

# In order for the docker to gain access to the gpus,
# the option --runtime=nividia needs to be supplied

docker run \
    --rm \
    --gpus all \
    pytorch_example:latest \
    nvidia-smi

# not needed anymore
#    --runtime=nvidia \
