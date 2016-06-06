#!/bin/bash

###
# This command is run on startup in order to obtain the setup scripts
###

### setup ssh keys ###
export GIT_SSH_COMMAND="ssh -i /keys/id_gogs"

printenv

echo $GIT_BUILD_URL

### clone build repo ###
git clone $GIT_BUILD_URL /tmp/build
