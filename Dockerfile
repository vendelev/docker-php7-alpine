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

# Install composer global bin 
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \\
    && php composer-setup.php --install-dir=/bin --filename=composer

# Install timezone and pinba
RUN apk add tzdata \
            git \
            g++ \
            gcc \
            make \
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone

RUN git clone https://github.com/tony2001/pinba_extension /tmp/pinba_extension \
    && cd /tmp/pinba_extension \
    && phpize \
    && ./configure --enable-pinba \
    && make install \
    && touch $PHP_DIR/conf.d/20-pinba.ini \
    && echo 'extension=pinba.so; pinba.enabled=1' > $PHP_DIR/conf.d/20-pinba.ini

EXPOSE 9000

RUN apk del tzdata \
            git \
            g++ \
            gcc \
            make \
    && rm -fr /var/cache/apk/* \
    && rm -fr /tmp/pinba_extension

CMD ["/usr/sbin/php-fpm7", "--nodaemonize"]
