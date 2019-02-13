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

        success {
            slackMessage("good")
        }
        unstable {
            slackMessage("danger")
        }
        failure {
            slackMessage("danger")
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
                script{
//                    def jsonSlurper = new JsonSlurper()
                    writeFile file: 'output.json', text: '''{"report": {"totalScenarios": 5,"totalFailed": 4,"totalSuccess": 1,"totalSkipped": 0,"totalUndefined": 0}}'''
//                    println(object)
//                    assert object.report.totalUndefined == 0
//                    def someMap = [[
//                            totalScenarios : 5,
//                            totalFailed : 1
//                    ]]
                    sh 'cat output.json'
                    sh 'ls'
                    def props = readJSON file: 'output.json'
                    println($props.report.totalScenarios)
                }

            }
        }

    }
}
def slackMessage(colorCode) {
script{
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
    slackSend(channel: '#jenkins_test', color: colorCode, attachments: new JsonBuilder(attachmenPayload).toPrettyString())
}
}

