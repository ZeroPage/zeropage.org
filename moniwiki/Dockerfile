FROM php:5.5-apache

COPY conf-available/remoteip.conf /etc/apache2/conf-available/remoteip.conf

RUN apt update && apt install -y \
    rcs \
    && a2enmod rewrite \
    && a2enmod remoteip \
    && a2enconf remoteip \
