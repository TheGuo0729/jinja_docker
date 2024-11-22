#!/usr/bin/env bash
USER_ID=$(id -u)
GROUP_ID=$(id -g)
PASSWD_FILE=$(mktemp) && echo $(getent passwd $USER_ID) > $PASSWD_FILE
GROUP_FILE=$(mktemp) && echo $(getent group $GROUP_ID) > $GROUP_FILE


xhost +local:
docker run -it --rm \
    -e HOME \
    -u $USER_ID:$GROUP_ID \
    -v $PASSWD_FILE:/etc/passwd:ro \
    -v $GROUP_FILE:/etc/group:ro \
    -v /mnt/ws-frb/users/jinjaguo/jinja-docker/home:$HOME \
    -v /mnt:/mnt \
    --name jinjaguo_ros_noetic \
    --gpus all \
    --ipc=host \
     -e DISPLAY \
    -e QT_X11_NO_MITSHM=1 \
    -e XDG_RUNTIME_DIR=/run/user/$USER_ID \
    -v /run/user/$USER_ID:/run/user/$USER_ID \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    jinjaguo/ros-noetic:latest # TODO: change this image name, container name and home directory accordingly
