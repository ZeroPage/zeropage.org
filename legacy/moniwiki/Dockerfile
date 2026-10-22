FROM php:8.3-apache

COPY conf-available/remoteip.conf /etc/apache2/conf-available/remoteip.conf
COPY moniwiki-polyfill.php /usr/local/lib/php/moniwiki-polyfill.php
COPY moniwiki.ini /usr/local/etc/php/conf.d/moniwiki.ini

RUN apt-get update && apt-get install -y --no-install-recommends \
    rcs \
    && rm -rf /var/lib/apt/lists/* \
    && a2enmod rewrite \
    && a2enmod remoteip \
    && a2enconf remoteip
