#!/usr/bin/bash

export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$UID/bus
export XDG_RUNTIME_DIR=/run/user/$UID

/bin/dockerd-rootless.sh $@