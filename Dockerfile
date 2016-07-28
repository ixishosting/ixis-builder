FROM debian:testing

WORKDIR /tmp

### Setup Rancher Compose command line tool ###
ADD https://github.com/rancher/rancher-compose/releases/download/v0.9.0/rancher-compose-linux-amd64-v0.9.0.tar.gz /tmp/

RUN tar xzvf rancher-compose-linux-amd64-v0.9.0.tar.gz && \
    mv rancher-compose-v0.9.0/rancher-compose /usr/bin && \
    rm -Rf /tmp/*

### Update apt cache ###
RUN apt-get update

### Install PHP and Drupal related tools ###
RUN apt-get install -y --allow-unauthenticated ca-certificates libedit2 libidn11 libmysqlclient18 libxml2 lsof mysql-common openssl php-console-table php-pear php-cli wget curl git

### Install composer and drush ###
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    wget -O /usr/local/bin/drush http://files.drush.org/drush.phar && \
    chmod +x /usr/local/bin/drush

RUN apt-get -y install --allow-unauthenticated ansible

### Install Jq ###
RUN apt-get -y install --allow-unauthenticated jq

### Add start script ###
COPY start.sh /start.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### Execute on start ###
CMD ["/bin/bash", "/start.sh"]
