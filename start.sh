#!/bin/bash

###
# This command is run on startup in order to obtain the setup scripts
###

### setup ssh keys ###
mkdir -p /root/.ssh
cat /keys/id_rsa > /root/.ssh/id_rsa
chmod 400 /root/.ssh/id_rsa

### stop ssh moaning about fingerprints ###
echo "StrictHostKeyChecking no" > ~/.ssh/config

### clone build repo ###
ssh-agent bash -c 'ssh-add /keys/id_rsa; git clone $GIT_BUILD_URL /tmp/build'

### run the build ###
bash /tmp/build/build.sh
