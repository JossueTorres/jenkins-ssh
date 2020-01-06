#!/bin/bash

DEBIAN_FRONTEND='noninteractive' apt-get install -y  apache2 \ 
php libapache2-mod-php php-fpm \ 
php-mysql php-gd && a2enmod proxy_fcgi setenvif && a2enconf php7.2-fpm
