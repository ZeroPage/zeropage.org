FROM php:7.1-apache

RUN apt update && apt install -y \
    libpng-dev \
    libssh2-1-dev \
    && echo '' | pecl install ssh2-1.1.2 \
    && docker-php-ext-install gd mysqli \
    && docker-php-ext-enable ssh2 \
    && a2enmod rewrite

