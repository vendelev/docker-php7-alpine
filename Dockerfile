FROM alpine

ENV TIMEZONE Europe/Moscow
ENV PHP_DIR /etc/php7

RUN apk update

# Install php 7
RUN apk add \
            php7 \
            php7-fpm \
            php7-mbstring \
            php7-iconv \
            php7-mysqli \
            php7-gd \
            php7-json \
            php7-memcached \
            php7-mcrypt \
            php7-amqp \
            php7-xdebug \
            php7-zip \
            php7-xml \
            php7-bcmath \
            php7-curl \
            php7-phar \
            php7-zlib \
            php7-pear \
            php7-soap \
            php7-pcntl \
            php7-ctype \
            php7-posix \
            php7-fileinfo \
            php7-session \
            php7-imagick \
            php7-opcache \
            php7-zip \
            php7-dev \
            php7-openssl \
    && ln -s /etc/php7 /etc/php \
    && ln -s /usr/sbin/php-fpm7 /usr/bin/php-fpm \
    && ln -s /usr/lib/php7 /usr/lib/php

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7", "--nodaemonize"]
