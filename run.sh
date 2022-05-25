#! /bin/bash
xhost local:root
docker run --tty --env DISPLAY="${DISPLAY}" --volume /tmp/.X11-unix:/tmp/.X11-unix igc
