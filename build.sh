#!/usr/bin/env bash
# SUPER DIRTY AND NOT FOR PUBLIC CONSUMPTION
# I AM ASHAMED DON'T LOOK SENPAI

docker pull debian:8

git submodule update --init
docker build -t buildenv_taskd buildenv/ && \
    docker run --rm --volume="$(pwd)/src:/usr/src" \
    --volume="$(pwd)/dist:/opt/taskd" buildenv_taskd && \
    docker build -t taskd .
