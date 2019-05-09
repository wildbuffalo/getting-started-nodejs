import groovy.json.*

//@Library('merrill-library@master') _
@Library('ds1-marketing-jenkins-library@master') _

pipeline {
    agent any
    options {
        skipDefaultCheckout()
        disableConcurrentBuilds()
    }
//    parameters {
//        string(name: 'repo', defaultValue: 'latest',description: 'repository name')
//        choice(name: 'deploy_env', choices: ['stage', 'prod'])
//        string(name: 'PCF_ENV', defaultValue: 'latest',)
//    }
    environment {
        JFROG = credentials("mrll-artifactory")
        CF_DOCKER_PASSWORD = "$JFROG_PSW"
        PCF = credentials("svc-inf-jenkins")
        repo = "$params.repo"
        deploy_env = "$params.deploy_env"
        PCF_ENV = "$params.PCF_ENV"
    }

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
        stage('Checkout') {
            //  agent any
            steps {
                checkout scm
                script {
                    env.gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                    env.getRepo = sh(returnStdout: true, script: "basename -s .git `git config --get remote.origin.url`").trim()
                    sh 'printenv'
//                    load 'src/com/dealworks/test.groovy'
//                    getItemData()
                    build(job: 'UTILS/autoscale', parameters: [string(name: 'repo', value: "dealworks-graphql-service"), string(name: 'deploy_env ', value: stage), string(name: 'PCF_ENV', value: blue)])
                    build(job: 'UTILS/autoscale', parameters: [string(name: 'repo', value: "dealworks-graphql-service"), string(name: 'deploy_env ', value: stage), string(name: 'PCF_ENV', value: green)])
                    build(job: 'UTILS/autoscale', parameters: [[$class: 'StringParameterValue', name: 'repo', value: "dealworks-graphql-service"],[$class: 'StringParameterValue', name: 'deploy_env', value: prod], [$class: 'StringParameterValue', name: 'PCF_ENV', value: blue]])
                    build(job: 'UTILS/autoscale', parameters: [string(name: 'repo', value: "dealworks-graphql-service"), string(name: 'deploy_env ', value: prod), string(name: 'PCF_ENV', value: green)])
                }
            }
        }
//        stage('Build'){
//            steps{
//                docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
//                    def dockerfile = './devops/Dockerfile'
//                    docker_image = docker.build("$repo/pr", "--pull --rm -f ${dockerfile} .")
//                    docker_image.inside {
//                        sh 'npm install'
//                    }
//                }
//            }
//        }
//        stage('Push to PCF') {
//            when {
//                expression { BRANCH_NAME ==~ /(master|stage|develop)/ }
//            }
//            steps {
//                script {
//                    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
//                        def dockerfile = "./devops/Dockerfile"
//                        docker_pcf_src = docker.build("docker_pcf_src", "--pull --rm -f ${dockerfile} .")
//                        docker_pcf_src.inside() {
//                                sh "cf login -a https://api.sys.us2.devb.foundry.mrll.com -u $PCF_USR -p $PCF_PSW -s devb -o us2-datasiteone &&\
//                                    cf zero-downtime-push $getRepo -f ./devops/manifest.yml"
//
//                        }
//                    }
//                }
//            }
//        }
    }
//        stage('autoscale') {
//
//            steps {
//                script {
//                    build (job: 'UTILS/autoscale',
//                            parameters: [
//                                    string(name: 'repo', value: 'dealworks-app'),
//                                    string(name: 'deploy_env ', value: 'stage')
//                            ])
//                }
//            }
//            post {
//                success {
//                    slackMessage("good")
//                }
//                unstable {
//                    slackMessage("danger")
//                }
//                failure {
//                    slackMessage("danger")
//                }
//            }
//        }


}
def slackMessage(colorCode) {
    script{
        writeFile file: 'output.json', text: '''{"report": {
\t\t"totalScenarios": 82,
\t\t"totalFailed": 23,
\t\t"totalSuccess": 54,
\t\t"totalSkipped": 0,
\t\t"totalUndefined": 1,
\t\t"totalDuration": "1308 seconds (21:48)"}}'''
        def props = readJSON file: 'output.json'
        attachmenPayload = [[
                                    fallback  : "${env.JOB_NAME} execution #${env.BUILD_NUMBER}",
                                    color     : colorCode,
                                    title     : "${env.JOB_NAME}",
                                    title_link: "${env.BUILD_URL}",
                                    text      : "",
                                    fields    :
                                            [
                                                    [
                                                            title: "Scenarios",
                                                            value: props.report.totalScenarios,
                                                            short: true
                                                    ], [
                                                            title: "Failed",
                                                            value: props.report.totalFailed,
                                                            short: true

                                                    ], [
                                                            title: "Success",
                                                            value: props.report.totalSuccess,
                                                            short: true
                                                    ], [
                                                            title: "Skipped",
                                                            value: props.report.totalSkipped,
                                                            short: true
                                                    ], [
                                                            title: "Undefined",
                                                            value: props.report.totalUndefined,
                                                            short: true
                                                    ]
                                            ]
                            ]]
        slackSend(channel: '#jenkins_test', color: colorCode, attachments: new JsonBuilder(attachmenPayload).toPrettyString())
    }
}


