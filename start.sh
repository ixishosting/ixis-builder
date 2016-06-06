#!/bin/bash

###
# This command is run on startup in order to obtain the setup scripts
###

### setup ssh keys ###
mkdir -p /root/.ssh/
cp /keys/id_gogs /root/.ssh/id_rsa
chmod 400 /root/.ssh/id_rsa

### clone build repo ###
git clone GIT_BUILD_URL /tmp/build
