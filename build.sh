#!/usr/bin/env bash
# SUPER DIRTY AND NOT FOR PUBLIC CONSUMPTION
# I AM ASHAMED DON'T LOOK SENPAI

git submodule update --init --recursive && \
docker build --pull -t mrdaemon/taskd:experimental .
