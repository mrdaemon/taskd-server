FROM debian:8

MAINTAINER Alexandre Gauthier <alex@lab.underwares.org>
LABEL description="TaskWarrior Server Image"

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
    libgnutls-deb0-28

# Copy binaries
WORKDIR /opt/taskd
COPY dist/ .
COPY taskd.sh .

USER nobody

ENV PATH "/opt/taskd/bin:$PATH"
EXPOSE 53589

CMD ["/opt/taskd/taskd.sh"]
