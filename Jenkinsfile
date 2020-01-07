def remote = [:]
remote.name = "wordpress_server"
remote.host = "172.17.0.6"
remote.allowAnyHosts = true

node {

    withCredentials([usernamePassword(credentialsId: 'sshUser', passwordVariable: 'password', usernameVariable: 'userName')]) {
        remote.user = userName
        remote.password = password
        stage("Setup") {
              sshCommand remote: remote, command: 'echo ***** Iniciando Instalaciones remotas *****'              
            // writeFile file: 'test.sh', text: 'ls -al ~'
            // sshCommand remote: remote, command: 'for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done'
            // sshScript remote: remote, script: 'test.sh'
            // sshPut remote: remote, from: 'test.sh', into: '.'
            // sshCommand remote: remote, command: 'ls -al'
            // sshGet remote: remote, from: 'test.sh', into: 'test_new.sh', override: true
            // sshRemove remote: remote, path: 'test.sh'             
        }
        stage("Configuración de servidor"){
            sshCommand remote: remote, command: '''
                echo *****Instalando Apache*****
                DEBIAN_FRONTEND='noninteractive' apt-get install -y apache2 
                echo *****Instalando php 7.2*****
                DEBIAN_FRONTEND='noninteractive' apt-get install -y php libapache2-mod-php php-fpm php-mysql php-gd 
                echo *****Ininicializando servicios*****
                a2enmod proxy_fcgi setenvif && a2enconf php7.2-fpm && a2enmod rewrite
                service apache2 start
                service php7.2-fpm start
                echo *****Creando archivo prueba*****
                touch /var/www/html/info.php
                echo '<?php phpinfo();' >> /var/www/html/info.php
                echo *****Reiniciando servicios*****
                service apache2 restart
                service php7.2-fpm restart
                echo *****Instalando MySQL*****
                DEBIAN_FRONTEND='noninteractive' apt-get install -y mysql-server mysql-cli
                service apache2 restart
                service php7.2-fpm restart
                sed -i '/<Directory \\/var\\/www\\/>/,/<\\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
                chgrp -R www-data /var/www
                find /var/www -type d -exec chmod 775 {} +
                find /var/www -type f -exec chmod 664 {} +
                chown -R mysql:mysql /var/lib/mysql /var/run/
                service mysql start
                mysql -h localhost -P 3306  < "
                    CREATE DATABASE wordpressdb DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
                    USE wordpressdb;
                    GRANT ALL ON wordpressdb.* TO ' wordpressuser '@'localhost' IDENTIFIED BY 'password';
                    FLUSH PRIVILEGES;
                "
            '''
        }
        stage("Copiar archivos a servidor"){

        }
    }
}