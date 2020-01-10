#!/bin/bash

apt-get update &&
echo *****Instalando Apache***** &&
DEBIAN_FRONTEND='noninteractive' apt-get install -y apache2 &&
echo *****Instalando php 7.2***** &&
DEBIAN_FRONTEND='noninteractive' apt-get install -y php libapache2-mod-php php-fpm php-mysql php-gd &&
echo *****Ininicializando servicios***** &&
a2enmod proxy_fcgi setenvif && a2enconf php7.2-fpm && a2enmod rewrite &&
service apache2 start &&
service php7.2-fpm start &&
echo *****Creando archivo prueba***** &&
touch /var/www/html/info.php &&
echo '<?php phpinfo();' > /var/www/html/info.php &&
echo *****Reiniciando servicios***** &&
service apache2 restart &&
service php7.2-fpm restart &&
echo *****Instalando MySQL***** &&
DEBIAN_FRONTEND='noninteractive' apt-get install -y mysql-server &&
service mysql start &&
sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf &&
chgrp -R www-data /var/www &&
find /var/www -type d -exec chmod 775 {} + &&
find /var/www -type f -exec chmod 664 {} + &&
echo *****Instalando git***** &&
DEBIAN_FRONTEND='noninteractive' apt-get install -y git