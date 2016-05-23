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

RUN apk add --update php php-openssl php-json php-phar php-ctype curl git

### Setup Composer and Drush 8

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    mkdir -p /opt/drush-8.x && \
    cd /opt/drush-8.x && \
    composer init --require=drush/drush:8.* -n && \
    composer config bin-dir /usr/local/bin && \
    composer install

WORKDIR /tmp
