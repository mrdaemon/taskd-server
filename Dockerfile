FROM debian:8

MAINTAINER Alexandre Gauthier <alex@lab.underwares.org>
LABEL description="TaskWarrior Server Image"

RUN useradd --system --user-group --home-dir /opt/taskd \
    --create-home --shell /bin/false taskd

# Create shitty "log" wrapper
RUN ln -sf /dev/stdout /var/log/taskd.log

# Set permissions
RUN chown taskd:taskd /var/taskd && \
    chmod 700 /var/taskd && \
    chown taskd:taskd /var/log/taskd.log

VOLUME /var/taskd

# Install runtime deps
RUN apt-get update && apt-get install -y \
    uuid \
    libgnutls-deb0-28

# Copy binaries
WORKDIR /opt/taskd
COPY dist/ .
COPY taskd.sh .

USER taskd

ENV PATH "/opt/taskd/bin:$PATH"
EXPOSE 53589

CMD ["/opt/taskd/taskd.sh"]
