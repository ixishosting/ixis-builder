#!/bin/bash

###
# This command is run on startup in order to obtain the setup scripts
###

### setup ssh keys ###
printenv

echo $GIT_BUILD_URL

### clone build repo ###
GIT_SSH_COMMAND='ssh -i /keys/id_gogs -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no' git clone $GIT_BUILD_URL /tmp/build
