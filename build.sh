#!/usr/bin/env bash
# SUPER DIRTY AND NOT FOR PUBLIC CONSUMPTION
# I AM ASHAMED DON'T LOOK SENPAI

docker pull debian:9

git submodule update --init && \
docker build -t taskd . 
