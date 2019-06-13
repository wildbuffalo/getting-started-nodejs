// def label = "mypod-${UUID.randomUUID().toString()}"
podTemplate(label: 'abc', containers: [
    containerTemplate(name: 'sonar', image: 'newtmitch/sonar-scanner', ttyEnabled: true, alwaysPullImage: true,),
    containerTemplate(name: 'git', image: 'mrllus2cbacr.azurecr.io/dealworks/tools', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'docker', image: 'docker', ttyEnabled: true, command: 'cat')
],
volumes: [
        hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
],
imagePullSecrets: [ 'cbacr' ]) 
  {


    pipeline {
        agent {
            'abc'
        }
        environment {
            JFROG = credentials("mrll-artifactory")
            CF_DOCKER_PASSWORD = "$JFROG_PSW"
            PCF = credentials("svc-inf-jenkins")
        }
        options {
            skipDefaultCheckout()
            disableConcurrentBuilds()
        }

        stages {
            stage('Checkout') {
                steps {
                    checkout scm
                    container('git') {
                    script {
                        env.gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                        env.REPO = sh(returnStdout: true, script: "basename -s .git `git config --get remote.origin.url`").trim()
                        env.VERSION = "latest"
                    }
                    }
                }
            }
            stage('Build') {
                steps {
                    container('docker') {
                    script {
                        sh "docker -v"
                    }}
                }
            }
        }
    }
    // node('abc') {
    //     stage('Get a Maven project') {
    //         git 'https://github.com/jenkinsci/kubernetes-plugin.git'
    //         container('sonar') {
    //             stage('Build a Maven project') {
    //                 sh 'sonar-scanner -v'
    //             }
    //         }
    //     }

    //     stage('Get a Golang project') {
    //         // git url: 'https://github.com/hashicorp/terraform.git'
    //         container('git') {
    //             stage('Build a Go project') {
    //                 sh "git --version"
    //             }
    //         }
    //     }
    //     stage('docker') {
    //         // git url: 'https://github.com/hashicorp/terraform.git'
    //         container('docker') {
    //             stage('Build a Go project') {
    //                 sh "docker -v"
    //             }
    //         }
    //     }

    // }
}