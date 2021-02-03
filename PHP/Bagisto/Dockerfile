FROM php:7.3-fpm

## Argument
ARG APP_ROOT=/var/www/html
ARG APP_USER=www-data

## Set default work directory
WORKDIR ${APP_ROOT}

## Install dependencies
RUN apt-get update && \
    apt-get install -y zip unzip gnupg2 cron vim \
    fonts-ipafont-gothic libfreetype6-dev libpng-dev libxpm-dev libwebp-dev libgmp-dev libjpeg62-turbo-dev libmcrypt-dev libicu-dev libxml2-dev 

## Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt-get install -y nodejs

## Install supervisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY ops/supervisord.conf /etc/supervisord.conf

## Install nginx
RUN apt-get install -y nginx
COPY ops/nginx-template.conf /etc/nginx/nginx.conf
COPY ops/default-template.conf /etc/nginx/conf.d/default.conf

## Install composer
RUN apt-get install -y wget && \
    mkdir -p /var/www/.composer && chown ${APP_USER}:${APP_USER} /var/www/.composer && \
    wget https://getcomposer.org/composer-1.phar && \
    chmod +x composer-1.phar && \
    mv composer-1.phar /usr/local/bin/composer

## Install php extensions
RUN apt-get install -y libzip-dev
RUN docker-php-ext-install gd pdo pdo_mysql intl pcntl mbstring tokenizer zip mysqli

## Run composer
COPY --chown=${APP_USER}:${APP_USER} composer.json composer.lock ${APP_ROOT}/
RUN composer global require laravel/installer
# RUN export COMPOSER_MEMORY_LIMIT=-1 && composer update
RUN export COMPOSER_PROCESS_TIMEOUT=900 && composer install --no-autoloader --no-scripts --no-plugins --no-dev



