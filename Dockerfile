FROM ubuntu:xenial

WORKDIR /tmp

### Setup Rancher Compose command line tool ###
ADD https://github.com/rancher/rancher-compose/releases/download/v0.10.0/rancher-compose-linux-amd64-v0.10.0.tar.gz /tmp/

RUN tar xzvf rancher-compose-linux-amd64-v0.10.0.tar.gz && \
    mv rancher-compose-v0.10.0/rancher-compose /usr/bin && \
    rm -Rf /tmp/*

### Update apt cache ###
RUN apt-get update

RUN apt-get -y --allow-unauthenticated install python-pip && \
    pip install awscli

### Install PHP and Drupal related tools ###
RUN apt-get install -y --allow-unauthenticated ca-certificates php-cli wget curl git

### Install composer and drush ###
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    wget -O /usr/local/bin/drush http://files.drush.org/drush.phar && \
    chmod +x /usr/local/bin/drush

RUN apt-get -y --allow-unauthenticated install software-properties-common && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get -y --allow-unauthenticated install ansible

### Install Jq ###
RUN apt-get -y --allow-unauthenticated install jq

### Install Docker ###
RUN apt-get -y --allow-unauthenticated install apt-transport-https ca-certificates
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN apt-get update
RUN apt-get -y --allow-unauthenticated install docker-engine

### Add start script ###
ADD start.sh /start.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### Execute on start ###
CMD ["/bin/bash", "/start.sh"]
