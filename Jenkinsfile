// def label = "mypod-${UUID.randomUUID().toString()}"
podTemplate(label: 'abc', containers: [
    containerTemplate(name: 'sonar', image: 'mrllus2cbacr.azurecr.io/dealworks/sonar-scanner', ttyEnabled: true, command: 'cat', alwaysPullImage: true,),
    containerTemplate(name: 'git', image: 'mrllus2cbacr.azurecr.io/dealworks/tools', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'docker', image: 'docker', ttyEnabled: true, command: 'cat')
],
volumes: [
        hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
],
imagePullSecrets: [ 'cbacr' ]) 
  {
    node('abc') {
        stage('Get a Maven project') {
            git 'https://github.com/jenkinsci/kubernetes-plugin.git'
            container('sonar') {
                stage('Build a Maven project') {
                    sh 'sonar-scanner -v'
                }
            }
        }

        stage('Get a Golang project') {
            // git url: 'https://github.com/hashicorp/terraform.git'
            container('git') {
                stage('Build a Go project') {
                    sh "cf -v"
                }
            }
        }
        stage('docker') {
            // git url: 'https://github.com/hashicorp/terraform.git'
            container('git') {
                stage('Build a Go project') {
                    sh "sonar-scanner -v"
                }
            }
        }

    }
}