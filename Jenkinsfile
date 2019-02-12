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
//
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
        stage('Build') {
            steps{
                println(props.report.totalScenarios)
            }


        }
    }

}

def props = readJSON text: '''{"report": {
"totalScenarios": 5,
"totalFailed": 4,
"totalSuccess": 1,
"totalSkipped": 0,
"totalUndefined": 0}}'''