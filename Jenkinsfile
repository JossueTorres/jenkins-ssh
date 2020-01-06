def remote = [:]
remote.name = "wordpress_server"
remote.host = "172.17.0.6"
remote.allowAnyHosts = true

node {

    withCredentials([usernamePassword(credentialsId: 'sshUser', passwordVariable: 'password', usernameVariable: 'userName')]) {
        remote.user = userName
        remote.password = password
        stage("Setup") {
              sshCommand remote: remote, command: 'echo **** Iniciando Instalaciones remotas ****'
            // writeFile file: 'test.sh', text: 'ls -al ~'
            // sshCommand remote: remote, command: 'for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done'
            // sshScript remote: remote, script: 'test.sh'
            // sshPut remote: remote, from: 'test.sh', into: '.'
            // sshCommand remote: remote, command: 'ls -al'
            // sshGet remote: remote, from: 'test.sh', into: 'test_new.sh', override: true
            // sshRemove remote: remote, path: 'test.sh'             
        }
        stage("Ejecutando..."){
            sshCommand remote: remote, command: '''
                DEBIAN_FRONTEND='noninteractive' apt-get install -y  apache2 php libapache2-mod-php php-fpm php-mysql php-gd 
                a2enmod proxy_fcgi setenvif && a2enconf php7.2-fpm
                service apache2 start
                service php7.2-fpm start
                touch /var/www/html/info.php
                echo '<?php phpinfo();' >> /var/www/html/info.php
                a2enmod rewrite
                
            '''
        }
    }
}