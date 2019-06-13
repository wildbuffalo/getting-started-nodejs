// def label = "mypod-${UUID.randomUUID().toString()}"
podTemplate(label: dealworks, containers: [
    containerTemplate(name: 'sonar', image: 'newtmitch/sonar-scanner', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'git', image: 'mrllus2cbacr.azurecr.io/dealworks/tools', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'docker', image: 'docker', ttyEnabled: true, command: 'cat')
  ],
    volumes: [
        hostPathVolume(mountPath: '/var/run/docker.sock',
        hostPath: '/var/run/docker.sock'
    ],
  imagePullSecrets: [ 'cbacr' ]
  ) 
  {
    node(label) {
        stage('Get a Maven project') {
            git 'https://github.com/jenkinsci/kubernetes-plugin.git'
            container('sonar') {
                stage('Build a Maven project') {
                    sh 'sonar-scaner -v'
                }
            }
        }

        stage('Get a Golang project') {
            // git url: 'https://github.com/hashicorp/terraform.git'
            container('git') {
                stage('Build a Go project') {
                    sh "git -v"
                }
            }
        }
        stage('docker') {
            // git url: 'https://github.com/hashicorp/terraform.git'
            container('docker') {
                stage('Build a Go project') {
                    sh "docker -v"
                }
            }
        }

    }
}