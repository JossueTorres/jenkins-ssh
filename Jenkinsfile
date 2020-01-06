def remote = [:]
remote.name = "wordpress_server"
remote.host = "172.17.0.6"
remote.allowAnyHosts = true

node {
    withCredentials([usernamePassword(credentialsId: 'sshUser', passwordVariable: 'password', usernameVariable: 'userName')]) {
        remote.user = userName
        remote.password = password
        stage("Setup") {
            // writeFile file: 'test.sh', text: 'ls -al ~'
            // sshCommand remote: remote, command: 'for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done'
            // sshScript remote: remote, script: 'test.sh'
            // sshPut remote: remote, from: 'test.sh', into: '.'
            // sshCommand remote: remote, command: 'ls -al'
            // sshGet remote: remote, from: 'test.sh', into: 'test_new.sh', override: true
            //sshRemove remote: remote, path: 'test.sh'
            sshCommand remote: remote, command: '**** Iniciando Instalaciones remotas ****'
        }
        // stage("Ejecutando..."){
        //     sshScript remote: remote, script: '$WORKSPACE/jenkins-ssh/config.sh'
        // }
    }
}