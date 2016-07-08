FROM frolvlad/alpine-glibc:alpine-3.4

WORKDIR /tmp

### Instal Bash shell ###
RUN apk add --no-cache bash

### Setup Rancher Compose command line tool ###
ADD https://github.com/rancher/rancher-compose/releases/download/v0.8.5/rancher-compose-linux-amd64-v0.8.5.tar.gz /tmp/

RUN tar xzvf rancher-compose-linux-amd64-v0.8.5.tar.gz && \
    mv rancher-compose-v0.8.5/rancher-compose /usr/bin && \
    rm -Rf /tmp/*

### Setup Amazon awscli command line tool ###
RUN apk add --no-cache python py-pip && \
    pip install awscli

### Install python-boto ###
#RUN pip install boto

### Install PHP and Drupal related tools ###
RUN apk add --no-cache php5 php5-openssl php5-json php5-phar php5-ctype curl git openssh

### Install composer and drush ###
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    wget -O /usr/local/bin/drush http://files.drush.org/drush.phar && \
    chmod +x /usr/local/bin/drush

### Install Ansible ###
RUN apk add --no-cache ansible py-boto

### Install Jq ###
RUN apk add --no-cache jq

### Add start script ###
COPY start.sh /start.sh

### Execute on start ###
CMD ["/bin/bash", "/start.sh"]
