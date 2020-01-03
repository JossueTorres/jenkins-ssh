// pipeline {
// //   environment {
// //     registry = "oscartorres97/test_repository"
// //     registryCredential = 'dockerhub'
// //     dockerImage = ''
// //   }
//   agent any
//   stages {
//     // stage('Cloning Git') {
//     //   steps {
//     //     git 'http://github.com/JossueTorres/jenkins-ssh'
//     //   }
//     // }
//     stage('Conectar SSH'){
//         steps{
//                 script{
//                 def remote = [:]
//                 remote.name = "Configuración"
//                 remote.host = "locahost"
//                 remote.allowAnyHosts = true

//                 node {
//                     withCredentials([sshUserPrivateKey(credentialsId: 'sshUser', keyFileVariable: 'identity', passphraseVariable: '', usernameVariable: 'userName')]) {
//                     remote.user = userName
//                     remote.identityFile = identity
//                     stage("SSH Steps Rocks!") {
//                             // writeFile file: 'abc.sh', text: 'ls'
//                             // sshCommand remote: remote, command: 'for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done'
//                             // sshPut remote: remote, from: 'abc.sh', into: '.'
//                             // sshGet remote: remote, from: 'abc.sh', into: 'bac.sh', override: true
//                             // sshScript remote: remote, script: 'abc.sh'
//                             // sshRemove remote: remote, path: 'abc.sh'
//                             sshCommand remote: remote, command: 'cat /proc/version'                          
//                         }
//                     }
//                 }
//             } 
//         }               
//     }
//     // stage('Configure Server: Apache - php 7.2') {
//     //   steps{
//     //     sh '''
//     //         DEBIAN_FRONTEND='noninteractive' apt-get install -y  apache2 \
//     //         php libapache2-mod-php php-fpm \
//     //         apt-get install -y php-mysql php-gd \
//     //         && a2enmod proxy_fcgi setenvif && a2enconf php7.2-fpm
//     //     '''
//     //   }
//     // }
//     // stage('Configure Server: MySQL') {
//     //   steps{
//     //     script {
//     //       docker.withRegistry( '', registryCredential ) {
//     //         dockerImage.push()
//     //       }
//     //     }
//     //   }
//     // }
//     // stage('Configure Server: WORDPRESS') {
//     //   steps{
//     //     sh "docker rmi $registry:$BUILD_NUMBER"
//     //   }
//     // }
//   }
// }

// def remote = [:]
// remote.name = "Prueba"
// remote.host = "localhost"
// remote.allowAnyHosts = true

// node {
//     checkout scm
//     withCredentials([usernamePassword(credentialsId: 'sshUser', passwordVariable: 'password', usernameVariable: 'userName')]) {
//         remote.user = userName
//         remote.password = password

//         stage("SSH Steps Rocks!") {
//             // writeFile file: 'test.sh', text: 'ls'
//             // sshCommand remote: remote, command: 'for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done'
//             // sshScript remote: remote, script: 'test.sh'
//             // sshPut remote: remote, from: 'test.sh', into: '.'
//             // sshGet remote: remote, from: 'test.sh', into: 'test_new.sh', override: true
//             // sshRemove remote: remote, path: 'test.sh'
//             //sshCommand remote: remote, command: 'cat /proc/version'
//             sshCommand remote: remote, command: "cat /proc/version"
//             // sh "DEBIAN_FRONTEND='noninteractive' apt-get install -y  apache2 \
//             //     php libapache2-mod-php php-fpm \
//             //     apt-get install -y php-mysql php-gd \
//             //     && a2enmod proxy_fcgi setenvif && a2enconf php7.2-fpm"
//             // sh "echo Finalizado"
//         }
//     }
// }

def remote = [:]
remote.name = "localhost"
remote.host = "127.0.0.1"
remote.allowAnyHosts = true

node {
    withCredentials([usernamePassword(credentialsId: 'sshUser2', passwordVariable: 'password', usernameVariable: 'userName')]) {
        remote.user = userName
        remote.password = password

        stage("SSH Steps Rocks!") {
            // writeFile file: 'test.sh', text: 'ls'
            
            // sshScript remote: remote, script: 'test.sh'
            // sshPut remote: remote, from: 'test.sh', into: '.'
            // sshGet remote: remote, from: 'test.sh', into: 'test_new.sh', override: true
            // sshRemove remote: remote, path: 'test.sh'
            sshCommand remote: remote, command: 'for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done'
        }
    }
}