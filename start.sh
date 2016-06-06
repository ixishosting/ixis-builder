#!/bin/bash

###
# This command is run on startup in order to obtain the setup scripts
###

### setup ssh keys ###
printenv

echo $GIT_BUILD_URL


### clone build repo ###
ssh-agent bash -c 'ssh-add /keys/id_gogs; git clone $GIT_BUILD_URL /tmp/build'
