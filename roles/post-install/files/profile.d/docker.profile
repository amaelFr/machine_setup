

## check if user docker host exist else use general one, frist chechk if var is defined
export DOCKER_HOST=unix:///run/user/$UID/docker.sock