def remote = [:]
remote.name = "wordpress_serv"
remote.host = "172.17.0.8"
remote.allowAnyHosts = true

node {

    withCredentials([usernamePassword(credentialsId: 'sshUser', passwordVariable: 'password', usernameVariable: 'userName')]) {
        remote.user = userName
        remote.password = password
        stage("Setup") {
              sshCommand remote: remote, command: 'echo ***** Iniciando Instalaciones remotas ***** && apt-get update'          
        }
        if ($CONFIG_SERVER == 'true') {
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
                    echo '<?php phpinfo();' > /var/www/html/info.php
                    echo *****Reiniciando servicios*****
                    service apache2 restart
                    service php7.2-fpm restart
                    echo *****Instalando MySQL*****
                    DEBIAN_FRONTEND='noninteractive' apt-get install -y mysql-server
                    service mysql start
                    chown -R mysql:mysql /var/lib/mysql /var/run/
                    sed -i '/<Directory \\/var\\/www\\/>/,/<\\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
                    chgrp -R www-data /var/www
                    find /var/www -type d -exec chmod 775 {} +
                    find /var/www -type f -exec chmod 664 {} +
                    echo *****Instalando git*****
                    DEBIAN_FRONTEND='noninteractive' apt-get install -y git
                '''
            }            
        }
        if($CLONE_REPO == 'true'){
            stage("Clonando repositorio"){
                sshCommand remote: remote, command: '''
                    echo *****Clonando Repositorio git*****
                    cd /var/www/html
                    git -c http.sslVerify=false clone https://github.com/JossueTorres/wordpress-prueba.git
                    cd wordpress-prueba
                    echo *****Quitar la verificación ssl self-signed certificate*****
                    git config http.sslVerify false
                '''
            }
        }   
        stage("Obteniendo Cambios del Repositorio"){
            sshCommand remote: remote, command: '''
                echo *****Haciendo Pull a Origin*****
                cd /var/www/html/wordpress-prueba
                git pull origin master
            '''
        }     
        stage("Restaurando Base de datos"){
            sshCommand remote: remote, command: '''
                echo *****Restaurando la Base de Datos*****
                mysql -h localhost -P 3306 -v < /var/www/html/wordpress-prueba/data/restore-07-01-2020.sql
            '''
        }
        stage("Finalizando"){
            sh'echo *****Finalizando la ejecución*****'
        }
    }
}