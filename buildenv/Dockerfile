FROM debian:8

MAINTAINER Alexandre Gauthier <alex@lab.underwares.org>
LABEL description="Build Environment for TaskWarrior Server"

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    uuid-dev \
    libgnutls28-dev

VOLUME /usr/src
VOLUME /opt/taskd

RUN mkdir /build
WORKDIR /build

CMD cmake -DCMAKE_INSTALL_PREFIX=/opt/taskd /usr/src/taskd.git && \
    make && make install

