#!/bin/bash

# With this command we use our custom docker to run a
# python script that exists on the host.

# We based our custom docker on pytorch/pytorch which uses
# /workspace as working dir inside the docker.
# So, we mount /srv/data/pytorch_example from the host to /workspace
# in the docker, so that /srv/data/pytorch_example/hello_world.py
# becomes available as /workspace/hello_world.py in the docker.

# Because /workspace is the working dir, we don't need to use the
# full path '/workspace/hello_world.py' when running the script,
# all though we could!

docker run \
    --rm \
    --gpus all \
    -v /srv/data/pytorch_example/:/workspace \
    pytorch_example:latest \
    python ./torch_example.py

