FROM php:7.1-apache

COPY conf-available/remoteip.conf /etc/apache2/conf-available/remoteip.conf

RUN apt update && apt install -y \
    libpng-dev \
    libssh2-1-dev \
    libicu-dev \
    && echo '' | pecl install ssh2-1.1.2 apcu \
    && docker-php-ext-configure intl \
    && docker-php-ext-install gd mysqli json pdo_mysql opcache exif fileinfo intl zip \
    && docker-php-ext-enable ssh2 intl apcu \
    && a2enmod rewrite \
    && a2enmod remoteip \
    && a2enconf remoteip \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
