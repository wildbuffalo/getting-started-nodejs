import groovy.json.*

@Library('merrill-library@master') _

pipeline {
    agent any
    options {
        skipDefaultCheckout()
        disableConcurrentBuilds()
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
        stage('autoscale') {

            steps {
//                script {
                    build (job: 'UTILS/autoscale',
                            parameters: [
//                                    $class: 'StringParameterValue',
//                                    name: 'repo',
//                                    value: repo[dealworks-app],
//                                    $class: 'StringParameterValue',
//                                    name: 'environment',
//                                    value: environment[stage]
                                    string(name: 'repo', value: 'dealworks-app'),
                                    string(name: 'environment ', value: 'stage')
                            ])
//                }
            }
        }
    }
}
//def slackMessage(colorCode) {
//    script{
//        def props = readJSON file: 'output.json'
//        attachmenPayload = [[
//                                    fallback  : "${env.JOB_NAME} execution #${env.BUILD_NUMBER}",
//                                    color     : colorCode,
//                                    title     : "${env.JOB_NAME}",
//                                    title_link: "${env.BUILD_URL}",
//                                    text      : "",
//                                    fields    :
//                                            [
//                                                    [
//                                                            title: "Scenarios",
//                                                            value: props.report.totalScenarios,
//                                                            short: true
//                                                    ], [
//                                                            title: "Failed",
//                                                            value: props.report.totalFailed,
//                                                            short: true
//
//                                                    ], [
//                                                            title: "Success",
//                                                            value: props.report.totalSuccess,
//                                                            short: true
//                                                    ], [
//                                                            title: "Skipped",
//                                                            value: props.report.totalSkipped,
//                                                            short: true
//                                                    ], [
//                                                            title: "Undefined",
//                                                            value: props.report.totalUndefined,
//                                                            short: true
//                                                    ]
//                                            ]
//                            ]]
//        slackSend(channel: '#jenkins_test', color: colorCode, attachments: new JsonBuilder(attachmenPayload).toPrettyString())
//    }
//}


