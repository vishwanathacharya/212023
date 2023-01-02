FROM php:7.3-apache
RUN apt-get update
#RUN apt-get install --asume-yes gpg libdbd-mysql-perl libapache2-mod-fcgid apache2 wget locales less gettext
RUN docker-php-ext-install mysqli
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y apt-utils 2>&1 | \
    grep -v "^devconf: delaying package configuration, since apt-utils.*"
RUN apt-get install -y \
        libzip-dev \
        zip \
        libpng-dev \
        && docker-php-ext-install gd && docker-php-ext-enable gd \
        && docker-php-ext-configure zip --with-libzip \
        && docker-php-ext-install zip
RUN docker-php-ext-install mysql pdo pdo_mysql && docker-php-ext-enable pdo_mysql
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 775 /var/www/html
RUN a2enmod rewrite

