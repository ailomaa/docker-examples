#!/bin/bash

# Need to be root to run this script

# Note that this is by no means a secure solution.
# This script will get files for an unmaintained version
# of debian and import it to a docker image.

# the snapshot url will decide the version of apt packages available
# on the system
debootstrap \
  --arch=amd64 \
  --no-check-gpg \
  wheezy \
  ./debian-wheezy \
  http://snapshot.debian.org/archive/debian/20140701T000000Z

# update repos
echo 'deb http://snapshot.debian.org/archive/debian/20140701T000000Z wheezy main' > ./debian-wheezy/etc/apt/sources.list
echo 'deb http://snapshot.debian.org/archive/debian-security/20140701T000000Z wheezy/updates main' >> ./debian-wheezy/etc/apt/sources.list

# so we can use apt-get without the proper key-kring
#echo 'Acquire::Check-Valid-Until "false";' > ./debian-wheezy/etc/apt/apt.conf.d/99no-check-valid-until
#echo 'APT::Get::AllowUnauthenticated "true";' > /etc/apt/apt.conf.d/99unauth
#echo 'Acquire::AllowInsecureRepositories "true";' > /etc/apt/apt.conf.d/99insecure

# create a tar
tar --numeric-owner -cf debian-wheezy.tar -C debian-wheezy/ .

# import from tar to debian
cat debian-wheezy.tar | docker import - debian:wheezy

# run and test
docker run --rm -it --network=host debian:wheezy bash -c 'apt-get update; apt-get install -y --force-yes build-essential'

# remove the image
docker image rm debian:wheezy
