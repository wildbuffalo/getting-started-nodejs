@Library('ds1-marketing-jenkins-library@master') _
pipeline {
    agent any
    options {
        skipDefaultCheckout()
        disableConcurrentBuilds()
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
        always{
            script {
                post_clean()
            }
        }
//        cleanup {
//            // clean the current workspace
//            cleanWs()
//            // clean the @tmp workspace
//            dir("${env.WORKSPACE}@tmp") {
//                cleanWs()
//            }
//            node('master') {
//                // clean the master @libs workspace
//                dir("${env.WORKSPACE}@libs") {
//                    cleanWs()
//                }
//                // clean the master @script workspace
//                dir("${env.WORKSPACE}@script") {
//                    cleanWs()
//                }
//            }
//        }

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
//
//
//
//                }
//            }
//
//        }
        stage('Build') {
            steps {
                script {

                    sh 'printenv'
                    sh 'ls'
//                    stage = params.stage
//                    version = params.version
//                    test( REPO, STAGE, VERSION)
//                    post_notification {}
//                    deployment( REPO, STAGE, VERSION)
//                    deployment()

                    sh 'ls'

                }
            }
        }
    }
}

//def test(body) {
//    // evaluate the body block, and collect configuration into the object
//    def config = [:]
//    body.resolveStrategy = Closure.DELEGATE_FIRST
//    body.delegate = config
//    body()
//    echo("$version")
//    sh("echo $env.WORKSPACE")
//
//}

def post_notification(body) {
    // evaluate the body block, and collect configuration into the object
    def config = [:]
    body.resolveStrategy = Closure.DELEGATE_FIRST
    body.delegate = config
    body()
    sh("echo $env.WORKSPACE")

}
