//library 'ds1_marketing_jenkins_library@master' _
@Library('ds1_marketing_jenkins_library@master') _

pipeline {
    agent any
//    libraries {
//        lib('wildbuffalo/ds1_marketing_jenkins_library@master')
//    }
    options {
        skipDefaultCheckout()
        disableConcurrentBuilds()
        //   ansiColor('xterm')
    }
    post {
        post_clean()
    }
    stages {

        stage('Checkout') {
            //  agent any
            steps {
                checkout scm
                script {
                    gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                    getRepo = sh(returnStdout: true, script: "basename -s .git `git config --get remote.origin.url`").trim()
                    sh 'printenv'
                }
            }

        }
        stage('Build') {
            steps {
                script {
//                    writeFile file: 'deploy.Dockerfile', text: "FROM merrillcorp-dealworks.jfrog.io/$getRepo/$version as source\n" +
//                            "FROM merrillcorp-dealworks.jfrog.io/tools:latest\n  " +
//                            "COPY --from=source /usr/src/app/ /home/jenkins/src/"
                    sh "echo $WORKSPACE"
                    sh "echo $env.WORKSPACE"
                    sh 'ls'
                    deployment("$getRepo","$BRANCH_NAME", 'ds')
                    sh 'ls'
                    sh 'cat deploy.Dockerfile'

//                    notification currentBuild.result
                }

            }
        }
    }
}
