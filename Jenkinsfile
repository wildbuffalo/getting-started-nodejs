import groovy.json.*

@Library('merrill-library@master') _

pipeline {
    agent any
    options {
        skipDefaultCheckout()
        disableConcurrentBuilds()
//        retry(2)
//        timeout(1)
        //   ansiColor('xterm')
    }
//    parameters {
//        string(name: 'REPO', description: 'repository name')
//        choice(name: 'STAGE', choices: ['develop', 'stage', 'master'], description: 'The branch is respect to the environment accordingly dev to dev env, stage to stage env, master to prod env')
//        string(name: 'VERSION', defaultValue: 'latest', description: 'pick your version from the artifactory')
//    }
//    environment {
//        JFROG = credentials("mrll-artifactory")
//        CF_DOCKER_PASSWORD = "$JFROG_PSW"
//        PCF = credentials("svc-inf-jenkins")
//        REPO = "$params.REPO"
//        STAGE = "$params.STAGE"
//        VERSION = "$params.VERSION"
//    }
    post {
        always{
            attachmenPayload = [[
                                        fallback  : "${env.JOB_NAME} execution #${env.BUILD_NUMBER}",
                                        color     : colorCode,
                                        title     : "${env.JOB_NAME}",
                                        title_link: "${env.RUN_DISPLAY_URL}",
                                        text      : "",
                                        fields    :
                                                [
                                                        [
                                                                title: "Scenarios",
                                                                value: "5",
                                                                short: true
                                                        ], [
                                                                title: "Failed",
                                                                value: "5",
                                                                short: true

                                                        ], [
                                                                title: "Success",
                                                                value: "5",
                                                                short: true
                                                        ], [
                                                                title: "Skipped",
                                                                value: "5",
                                                                short: true
                                                        ], [
                                                                title: "Undefined",
                                                                value: "5",
                                                                short: true
                                                        ]
                                                ]
                                ]]
        }
        success {
            slackSend(channel: '@zeng liu', color: 'good', attachments: new JsonBuilder(attachmenPayload).toPrettyString())
        }
        unstable {
            slackSend(channel: '@zeng liu', color: 'danger', attachments: new JsonBuilder(attachmenPayload).toPrettyString())
        }
        failure {
            slackSend(channel: '@zeng liu', color: 'danger', attachments: new JsonBuilder(attachmenPayload).toPrettyString())
        }

        cleanup {
            cleanWs()
            dir("${env.WORKSPACE}@tmp") {
                cleanWs()
            }
            node('master') {
                dir("${env.WORKSPACE}@libs") {
                    cleanWs()
                }
                dir("${env.WORKSPACE}@script") {
                    cleanWs()
                }
            }
        }
    }

    stages {
//        stage('Checkout') {
//            //  agent any
//            steps {
//                checkout scm
//                script {
//                    env.gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
//                    env.getRepo = sh(returnStdout: true, script: "basename -s .git `git config --get remote.origin.url`").trim()
//                    sh 'printenv'
//                }
//            }
//        }
        stage('Build') {
            steps {
                sh 'ls'
            }
        }

    }
}

