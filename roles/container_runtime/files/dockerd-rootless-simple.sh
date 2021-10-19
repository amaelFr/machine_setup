#!/usr/bin/bash

export XDG_RUNTIME_DIR=$HOME/.docker/run
mkdir -p $XDG_RUNTIME_DIR
chmod 750 $HOME/.docker $XDG_RUNTIME_DIR

/bin/dockerd-rootless.sh $@