//library 'ds1_marketing_jenkins_library@master' _
@Library('ds1_marketing_jenkins_library@master') _

pipeline {
    agent any
    environment {
        JFROG=credentials("mrll-artifactory")
        CF_DOCKER_PASSWORD="$JFROG_PSW"
        PCF=credentials("svc-inf-jenkins")
        ABC="123"
    }
    options {
        skipDefaultCheckout()
        disableConcurrentBuilds()
        //   ansiColor('xterm')
    }
    post {
        cleanup {
            // clean the current workspace
            cleanWs()
            // clean the @tmp workspace
            dir("${env.WORKSPACE}@tmp") {
                cleanWs()
            }
            node('master') {
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

    stages {

        stage('Checkout') {
            //  agent any
            steps {
                checkout scm
                script {
                    gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                    getRepo = sh(returnStdout: true, script: "basename -s .git `git config --get remote.origin.url`").trim()
                    sh 'printenv'
                    post_notification()

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
def test(body) {
    // evaluate the body block, and collect configuration into the object
    def config = [:]
    body.resolveStrategy = Closure.DELEGATE_FIRST
    body.delegate = config
    body()
    echo("$ABC")
    sh("echo $env.WORKSPACE")

}
def post_notification(body){
    // evaluate the body block, and collect configuration into the object
    def config = [:]
    body.resolveStrategy = Closure.DELEGATE_FIRST
    body.delegate = config
    body()
            echo("$ABC")
            sh("echo $env.WORKSPACE")

}