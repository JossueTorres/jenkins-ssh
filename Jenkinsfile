def remote = [:]
remote.name = "ubu_ser"
remote.host = "172.17.0.2"
remote.password = ""
remote.allowAnyHosts = true

node {
    withCredentials([usernamePassword(credentialsId: 'sshUser', passwordVariable: 'password', usernameVariable: 'userName')]) {
        remote.user = userName
        remote.password = password
        stage("Enviar notificación"){
            emailext body: 'Este es un correo de prueba', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Jenkins - Test', to: 'ossue97@gmail.com'
        }
        stage("Setup") {
              sshCommand remote: remote, command: 'echo ***** Iniciando Instalaciones remotas ***** && apt-get update'          
        }
        if ($CONFIG_SERVER == 'true') {
            stage("Configuración de servidor"){
                //steps{
                    sshScript remote: remote, script: '/var/jenkins_home/config.sh'
                    // sshCommand remote: remote, command: '''
                    //     echo *****Instalando Apache*****
                    //     DEBIAN_FRONTEND='noninteractive' apt-get install -y apache2 
                    //     echo *****Instalando php 7.2*****
                    //     DEBIAN_FRONTEND='noninteractive' apt-get install -y php libapache2-mod-php php-fpm php-mysql php-gd 
                    //     echo *****Ininicializando servicios*****
                    //     a2enmod proxy_fcgi setenvif && a2enconf php7.2-fpm && a2enmod rewrite
                    //     service apache2 start
                    //     service php7.2-fpm start
                    //     echo *****Creando archivo prueba*****
                    //     touch /var/www/html/info.php
                    //     echo '<?php phpinfo();' > /var/www/html/info.php
                    //     echo *****Reiniciando servicios*****
                    //     service apache2 restart
                    //     service php7.2-fpm restart
                    //     echo *****Instalando MySQL*****
                    //     DEBIAN_FRONTEND='noninteractive' apt-get install -y mysql-server
                    //     service mysql start                    
                    //     sed -i '/<Directory \\/var\\/www\\/>/,/<\\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
                    //     chgrp -R www-data /var/www
                    //     find /var/www -type d -exec chmod 775 {} +
                    //     find /var/www -type f -exec chmod 664 {} +
                    //     echo *****Instalando git*****
                    //     DEBIAN_FRONTEND='noninteractive' apt-get install -y git
                    // '''
                //}                
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

        // Sonar Stages
        // stage("SonarQube analysis") {
        //     node {
        //         withSonarQubeEnv('SonarQube') {
        //             sh "/opt/sonar-scanner-4.2.0.1873-linux/bin/sonar-scanner"   
        //         }
        //         def qualitygate = waitForQualityGate()
        //         if (qualitygate.status != "OK") {
        //             error "Pipeline aborted due to quality gate coverage failure: ${qualitygate.status}"
        //         }
        //     }
        // }

        node {
            stage('SCM') {
                git 'https://github.com/JossueTorres/jenkins-ssh.git'
            }
            // stage('SonarQube analysis') {

            //     def scannerHome = tool 'LocalSonarScanner';
            //     withSonarQubeEnv() { // If you have configured more than one global server connection, you can specify its name
            //         sh "${scannerHome}/sonar-scanner"
            //     }
            // }
        }

        if($RESTORE_DB == 'true'){
            stage("Restaurando Base de datos"){
            sshCommand remote: remote, command: '''
                    echo *****Restaurando la Base de Datos*****
                    mysql -h localhost -P 3306 -v < /var/www/html/wordpress-prueba/data/restore-07-01-2020.sql
                '''
            }
        }        
        stage("Finalizando"){
            sh'echo *****Finalizando la ejecución*****'
        }
    }
}