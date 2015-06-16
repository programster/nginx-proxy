FROM ubuntu:trusty
MAINTAINER Stuart Page sdpagent@gmail.com

# Install wget and install/updates certificates
RUN apt-get update && apt-get install nginx-extras wget cron vim -y

# replace the nginx configuration.
ADD nginx.conf /etc/nginx/nginx.conf

# Install and setup docker gen for automatically configuring nginx for us.
ENV DOCKER_GEN_VERSION 0.3.9
RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

ENV DOCKER_HOST unix:///tmp/docker.sock

# Define mountable directories (taken from nginx dockerfile)
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Add all of self to /root/app
# If you want to take this out, make sure to keep the nginx.tmpl there for dockergen (see startup.sh)
ADD . /root/app/.

# Expose ports.
EXPOSE 80
EXPOSE 443

ADD startup.sh /root/startup.sh
CMD ["/bin/bash", "/root/startup.sh"]
