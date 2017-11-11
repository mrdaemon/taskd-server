# Intermediate Build Container
FROM debian:9 AS taskd_buildenv

RUN apt-get update && apt-get install -y \
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
    make && make install

# Runtime image
FROM debian:9

LABEL maintainer="Alexandre Gauthier <alex@lab.underwares.org>" \
      description="TaskWarrior Server"

# Create runtime directories and files
RUN ln -sf /dev/stdout /var/log/taskd.log && \
    mkdir -p /var/taskd

# Set permissions
RUN chown nobody:nogroup /var/taskd && \
    chmod 700 /var/taskd && \
    chown nobody:nogroup /var/log/taskd.log

VOLUME /var/taskd

# Install runtime deps
RUN apt-get update && apt-get install -y \
    uuid \
    libgnutls30

# Copy binaries off intermediate build container
WORKDIR /opt/taskd
COPY --from=taskd_buildenv /opt/taskd .
COPY taskd.sh .

# Set explicit permissions and drop to unprivileged user
#RUN chown -R root:root /opt/taskd && \
#    find /opt/taskd/bin -type f -exec chmod ugo+rx,go-w {} \; && \
#    find /opt/taskd/share -type f -exec chmod ugo+r,ugo-x {} \; && \ 
#    chmod go-w,ugo+rx taskd.sh
USER nobody

ENV PATH "/opt/taskd/bin:$PATH"
EXPOSE 53589

CMD ["/opt/taskd/taskd.sh"]
