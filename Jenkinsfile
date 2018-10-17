

pipeline {
    agent none
    //environment {
    //   JFROG=credentials("mrll-artifactory")
    //   CF_DOCKER_PASSWORD="$JFROG_PSW"
    // }
    options {
        skipDefaultCheckout()
        ansiColor('xterm')
    }
    stages {

        stage('Checkout') {
            agent any
            steps {
                checkout scm
                script {

                    gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                    //shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()

                }


            }
        }


        stage('Build') {
            steps {
                script {

                    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

                        def dockerfile = 'Dockerfile'
                        docker_image = docker.build("node/master:${gitCommit}", "-f ${dockerfile} .")

                        /* Push the container to the custom Registry */
                        docker_image.inside {

                            sh 'printenv'

                        }

                    }


                }
            }
        }

        stage('Push to Artifactory') {

            steps{
                script {
                    docker_image.push('latest')
                    docker_image.push()
                }
            }
        }
    }
}


