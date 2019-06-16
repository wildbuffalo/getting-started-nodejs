import groovy.json.*

//@Library('merrill-library@master') _
@Library('ds1-marketing-jenkins-library@master') _

pipeline {
    agent {
        node {label 'dealworks'}
//         kubernetes {
//             label 'mypod'
//             defaultContainer 'jnlp'
//             yaml """
// apiVersion: v1
// kind: Pod
// metadata:
//   labels:
//     some-label: some-label-value
// spec:
//   containers:
//   - name: tools  
//     image: mrllus2cbacr.azurecr.io/dealworks/sonar-scanner  
//     tty: true
//     command:
//     - cat
//   - name: node
//     image: node:10-alpine
//     tty: true
//     command:
//     - cat
//   - name: docker    
//     image: docker
//     tty: true
//     command:
//     - cat
//     volumeMounts:
//     - name: dockersock
//       mountPath: /var/run/docker.sock
//   volumes:
//   - name: dockersock
//     hostPath:
//       path: /var/run/docker.sock
//   imagePullSecrets:
//   -   name: cbacr
//   """
//         }
    }
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
        PCF = credentials("PCF")

    }
//
//    post {
//        cleanup {
//            cleanWs()
//            dir("${env.WORKSPACE}@tmp") {
//                cleanWs()
//            }
//            node('master') {
//                dir("${env.WORKSPACE}@libs") {
//                    cleanWs()
//                }
//                dir("${env.WORKSPACE}@script") {
//                    cleanWs()
//                }
//            }
//        }
//    }

    stages {
        stage('Checkout') {
            //  agent any
            steps {
                container('tools') {
                    // checkout scm
                    sh 'sonar-scanner '
                    script {
//                    env.gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
//                    repo = sh(returnStdout: true, script: "basename -s .git `git config --get remote.origin.url`").trim()
                        sh 'sonar-scanner '
//                    withEnv(['API_DOMAIN_G=apps.eu2.prodg.foundry.mrll.com', 'API_DOMAIN_B=apps.eu2.prodb.foundry.mrll.com','APOLLO_ENGINE_KEY=service:ds1marketing-prod-eu:vcQfDMrixBnFuowjbxSK-g']) {
//                        echo "$API_DOMAIN_G,$API_DOMAIN_B,$APOLLO_ENGINE_KEY"
//                    }

//                    withDockerContainer(args: '-u root', image: 'microsoft/azure-cli') {
//                        withCredentials([azureServicePrincipal('A_SP')]) {
//                            echo "$AZURE_SUBSCRIPTION_ID or $AZURE_TENANT_ID or $AZURE_CLIENT_SECRET or $AZURE_CLIENT_ID"
//                            sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
//                        }
//                    }

//                    load 'src/com/dealworks/test.groovy'
//                    getItemData()
//                    build job: '/UTILS/autoscale', parameters: [string(name: 'repo', value: 'dealworks-graphql-service'), string(name: 'deploy_env', value: 'stage'), string(name: 'PCF_ENV', value: 'blue')], quietPeriod: 0, wait: false
//                    build job: '/UTILS/autoscale', parameters: [string(name: 'repo', value: 'dealworks-graphql-service'), string(name: 'deploy_env', value: 'stage'), string(name: 'PCF_ENV', value: 'green')], quietPeriod: 0, wait: false
//                    build job: '/UTILS/autoscale', parameters: [string(name: 'repo', value: 'dealworks-graphql-service'), string(name: 'deploy_env', value: 'prod'), string(name: 'PCF_ENV', value: 'blue')], quietPeriod: 0, wait: false
//                    build job: '/UTILS/autoscale', parameters: [string(name: 'repo', value: 'dealworks-graphql-service'), string(name: 'deploy_env', value: 'prod'), string(name: 'PCF_ENV', value: 'green')], quietPeriod: 0, wait: false
                    }
                }
            }
        }
//         stage('Build') {
//             steps {
//                 script {
//                     docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
// //                        def dockerfile = './Dockerfile'
// //                        docker_image = docker.build("$repo", "--pull --rm -f ${dockerfile} .")
// //                        docker_image.inside {
// //                            sh 'ls'
// //                        }
//                         def customImage = docker.build("merrillcorp-dealworks.jfrog.io/getting-started-nodejs:latest", "--pull")
//                         customImage.inside {
//                             sh "ls"
//                         }
//                     }
//                 }
//             }
//         }
//         stage('Archive to Artifactory') {
//             when {
//                 expression { BRANCH_NAME ==~ /(master|stage|develop)/ }
//             }
//             steps {
//                 script {
//                     docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
//                         docker_image.push('latest')
//                         docker_image.push()
//                     }
//                 }
//             }
//         }
//         stage('Push to PCF') {
//             when {
//                 expression { BRANCH_NAME ==~ /(master|stage|develop)/ }
//             }
//             steps {
//                 script {
// //                    def manifest = libraryResource "com/merrill/dealworks/dealworks-graphql-service/manifest.yml"
// //                    writeFile file: '/home/jenkins/src/manifest.yml', text: "$manifest"
//                     docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
//                         def dockerfile = "./devops/Dockerfile"
//                         docker_pcf_src = docker.build("docker_pcf_src", "--pull --rm -f ${dockerfile} .")
//                         docker_pcf_src.inside() {
//                             sh "cf login -a https://api.sys.us2.devb.foundry.mrll.com -u $PCF_USR -p $PCF_PSW -s devb -o us2-datasiteone &&\
//                                     cf zero-downtime-push $repo -f ./devops/manifest.yml"
//                         }
//                     }
//                 }
//             }
//         }
//     }
// //        stage('autoscale') {
// //
// //            steps {
// //                script {
// //                    build (job: 'UTILS/autoscale',
// //                            parameters: [
// //                                    string(name: 'repo', value: 'dealworks-app'),
// //                                    string(name: 'deploy_env ', value: 'stage')
// //                            ])
// //                }
// //            }
// //            post {
// //                success {
// //                    slackMessage("good")
// //                }
// //                unstable {
// //                    slackMessage("danger")
// //                }
// //                failure {
// //                    slackMessage("danger")
// //                }
// //            }
// //        }
// }

// def slackMessage(colorCode) {
//     script {
//         writeFile file: 'output.json', text: '''{"report": {
// \t\t"totalScenarios": 82,
// \t\t"totalFailed": 23,
// \t\t"totalSuccess": 54,
// \t\t"totalSkipped": 0,
// \t\t"totalUndefined": 1,
// \t\t"totalDuration": "1308 seconds (21:48)"}}'''
//         def props = readJSON file: 'output.json'
//         attachmenPayload = [[
//                                     fallback  : "${env.JOB_NAME} execution #${env.BUILD_NUMBER}",
//                                     color     : colorCode,
//                                     title     : "${env.JOB_NAME}",
//                                     title_link: "${env.BUILD_URL}",
//                                     text      : "",
//                                     fields    :
//                                             [
//                                                     [
//                                                             title: "Scenarios",
//                                                             value: props.report.totalScenarios,
//                                                             short: true
//                                                     ], [
//                                                             title: "Failed",
//                                                             value: props.report.totalFailed,
//                                                             short: true

//                                                     ], [
//                                                             title: "Success",
//                                                             value: props.report.totalSuccess,
//                                                             short: true
//                                                     ], [
//                                                             title: "Skipped",
//                                                             value: props.report.totalSkipped,
//                                                             short: true
//                                                     ], [
//                                                             title: "Undefined",
//                                                             value: props.report.totalUndefined,
//                                                             short: true
//                                                     ]
//                                             ]
//                             ]]
//         slackSend(channel: '#jenkins_test', color: colorCode, attachments: new JsonBuilder(attachmenPayload).toPrettyString())
//     }
// }
    }}

