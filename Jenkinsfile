#!groovy
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
        /*
         * These steps will run at the end of the pipeline based on the condition.
         * Post conditions run in order regardless of their place in pipeline
         * 1. always - always run
         * 2. changed - run if something changed from last run
         * 3. aborted, success, unstable or failure - depending on status
         */
//        always {
//            notification 'STARTED'
////            notification currentBuild.result
//            //sh 'docker system prune --all --force --volumes'
//        }

        // intergrating with assyst for change control
        cleanup {
            // clean the current workspace
            cleanWs()
            // clean the @tmp workspace
            dir("${env.WORKSPACE}@tmp") {
                cleanWs()
            }
            script {
                node ('master') {
                    // clean the master @libs workspace
                    dir("${env.WORKSPACE}@libs") {
                        cleanWs()
                    }
                    // clean the master @script workspace
                    dir("${env.WORKSPACE}@script") {
                        cleanWs()
                    }
                }
            }
        }
    }
    stages {

        stage('Checkout') {
            //  agent any
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps{
                script{
//                    if (!isPRMergeBuild()) {
//                        Build()
//                    } else {
//                        PR_build()
//
//                    }
                    writeFile file: 'deploy.Dockerfile', text: "FROM golang:onbuild" +
                            "sdsds" +
                            "" +
                            "   dsddsd"
                    sh 'ls'
                    sh 'cat deploy.Dockerfile'
//                    notification currentBuild.result
                }

            }
        }
    }
}
//def PR_build(){
//
//
//        def dockerfile = './devops/Dockerfile'
//        docker_image = docker.build("$repo/pr", "--pull -f ${dockerfile} .")
//        /* Push the container to the custom Registry */
//        docker_image.inside {
//            sh 'npm -v'
//            sh 'npm install'
//
//
//    }
//}
//
//def Build(){
//        def dockerfile = './devops/Dockerfile'
//        docker_image = docker.build("$repo/$BRANCH_NAME:${gitCommit}", "--pull -f ${dockerfile} .")
//        /* Push the container to the custom Registry */
//        docker_image.inside {
//            sh 'npm -v'
//            sh 'npm install'
//        }
//}
//
//def isPRMergeBuild() {
//    return (env.BRANCH_NAME ==~ /^PR-\d+$/)
//}
