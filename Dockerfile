# Intermediate Build Container
FROM debian:10 AS taskd_buildenv

RUN apt-get update && apt-get install -y \
    coreutils \
    build-essential \
    cmake \
    uuid-dev \
    libgnutls28-dev

# Create build, source and dist directories
RUN mkdir /build && mkdir -p /opt/taskd && mkdir -p /usr/src
WORKDIR /build

# Copy source code to build image
COPY src/taskd.git /usr/src/taskd.git

# Perform build
RUN cmake -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/opt/taskd /usr/src/taskd.git && \
    make -j$(($(nproc)+1)) && make install

# Runtime image
FROM debian:10-slim

LABEL maintainer="Alexandre Gauthier <alex@lab.underwares.org>" \
      description="TaskWarrior Server"

# Create runtime directories and files
RUN ln -sf /dev/stdout /var/log/taskd.log && \
    mkdir -p /var/taskd

VOLUME /var/taskd

# Install runtime deps, remove apt cache
RUN apt-get update && apt-get install --no-install-recommends -y \
    uuid \
    libgnutls30 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy binaries off intermediate build container
WORKDIR /opt/taskd
COPY --from=taskd_buildenv /opt/taskd .
COPY taskd.sh .

ENV PATH "/opt/taskd/bin:$PATH"
EXPOSE 53589

CMD ["/opt/taskd/taskd.sh"]
