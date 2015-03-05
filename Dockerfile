# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM ubuntu:14.04
MAINTAINER Lewis Wright <lewis@allwrightythen.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# Install composer & scrutinizer
COPY . /etc/scrutinizer/
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        # Install PHP tools
        php5-cli \
        php5-curl \
        nodejs-legacy \
        npm \
        git

RUN curl https://getcomposer.org/installer | php \
 && mv composer.phar /usr/local/bin/composer

# Install scrutinizer
RUN cd /etc/scrutinizer \
 && composer install --no-dev \
 && npm install \
 && ln -s /etc/scrutinizer/bin/scrutinizer /usr/local/bin/scrutinizer

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
