#!/bin/bash

# remove earlier build
docker rm webapp:latest

# build
#docker build --tag webapp:latest .
# workaround on Linux behind VPN
docker build --network=host --tag webapp:latest .

# run
docker run --rm -p 127.0.0.1:5000:5000 webapp:latest
# check http://127.0.0.1:5000
