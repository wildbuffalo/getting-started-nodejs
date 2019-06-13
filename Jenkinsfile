def label = "mypod-${UUID.randomUUID().toString()}"
podTemplate(label: label, containers: [
    containerTemplate(name: 'gradle', image: 'amd64/gradle:latest', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'git', image: 'alpine/git:latest', ttyEnabled: true, command: 'cat')
  ]) {

    node(label) {
        stage('Get a Maven project') {
            git 'https://github.com/jenkinsci/kubernetes-plugin.git'
            container('gradle') {
                stage('Build a Maven project') {
                    sh 'gradle -v'
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

    }
}