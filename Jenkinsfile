pipeline {
//   environment {
//     registry = "oscartorres97/test_repository"
//     registryCredential = 'dockerhub'
//     dockerImage = ''
//   }
  agent any
  stages {
    // stage('Cloning Git') {
    //   steps {
    //     git 'http://github.com/JossueTorres/jenkins-ssh'
    //   }
    // }
    stage('Conectar SSH'){
        script{
            def remote = [:]
            remote.name = "Configuración"
            remote.host = "locahost"
            remote.allowAnyHosts = true

            node {
                withCredentials([sshUserPrivateKey(credentialsId: 'sshUser', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'root')]) {
                remote.user = userName
                remote.identityFile = identity
                stage("SSH Steps Rocks!") {
                        // writeFile file: 'abc.sh', text: 'ls'
                        // sshCommand remote: remote, command: 'for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done'
                        // sshPut remote: remote, from: 'abc.sh', into: '.'
                        // sshGet remote: remote, from: 'abc.sh', into: 'bac.sh', override: true
                        // sshScript remote: remote, script: 'abc.sh'
                        // sshRemove remote: remote, path: 'abc.sh'
                        sshCommand remote: remote, command: 'cat /proc/version'
                    }
                }
            }
        }        
    }
    // stage('Configure Server: Apache - php 7.2') {
    //   steps{
    //     sh '''
    //         DEBIAN_FRONTEND='noninteractive' apt-get install -y  apache2 \
    //         php libapache2-mod-php php-fpm \
    //         apt-get install -y php-mysql php-gd \
    //         && a2enmod proxy_fcgi setenvif && a2enconf php7.2-fpm
    //     '''
    //   }
    // }
    // stage('Configure Server: MySQL') {
    //   steps{
    //     script {
    //       docker.withRegistry( '', registryCredential ) {
    //         dockerImage.push()
    //       }
    //     }
    //   }
    // }
    // stage('Configure Server: WORDPRESS') {
    //   steps{
    //     sh "docker rmi $registry:$BUILD_NUMBER"
    //   }
    // }
  }
}