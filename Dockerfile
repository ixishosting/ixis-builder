FROM frolvlad/alpine-glibc

WORKDIR /tmp

### Instal Bash shell ###

RUN apk add --update bash

### Setup Rancher Compose command line tool

ADD https://github.com/rancher/rancher-compose/releases/download/v0.7.4/rancher-compose-linux-amd64-v0.7.4.tar.gz /tmp/

RUN tar xzvf rancher-compose-linux-amd64-v0.7.4.tar.gz && \
    mv rancher-compose-v0.7.4/rancher-compose /usr/bin && \
    rm -Rf /tmp/*

### Setup Amazon awscli command line tool

RUN apk add --update python && \
    apk add --update py-pip && \
    pip install awscli

### Install PHP and Drupal related tools

RUN apk add --update php php-openssl php-json php-phar php-ctype curl git openssh

### Setup Composer and Drush 8

# install composer and drush
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    wget -O /usr/local/bin/drush http://files.drush.org/drush.phar && \
    chmod +x /usr/local/bin/drush

WORKDIR /tmp
