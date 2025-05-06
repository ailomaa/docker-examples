#!/bin/bash

#docker build -t pytorch_example:latest .
docker build --network=host -t pytorch_example:latest .
