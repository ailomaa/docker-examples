#!/bin/bash

sudo debootstrap --arch=amd64 --variant=minbase buster ./debian-buster
sudo tar --numeric-owner -cf debian-buster.tar -C debian-buster/ .
docker import ./debian-buster.tar custom-debian:buster
