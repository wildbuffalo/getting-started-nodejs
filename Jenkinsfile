


pipeline {
    agent any

    environment {
        JFROG=credentials("mrll-artifactory")
        CF_DOCKER_PASSWORD="$JFROG_PSW"
        PCF=credentials("svc-inf-jenkins")
//        repoName="dealworks-app"
    }
    options {
        disableConcurrentBuilds()
        skipDefaultCheckout()
        ansiColor('xterm')
    }
    parameters {
//        string(name: 'REPO', defaultValue: 'dealworks-app')
        string(name: 'SRC_PATH', defaultValue: 'mrll-npm/@mrll/dealworks-app/-/@mrll/dealworks-app-1.0.294.tgz')

        // booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')

        choice(name: 'Space', choices: ['devg', 'stageg', 'prod'], description: 'PCF spaces')
        choice(name: 'Manifest', choices: ['manifest-dev', 'manifest-stage', 'manifest-prod'], description: 'PCF manifest file')

        // password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')

    }
    post {
        /*
         * These steps will run at the end of the pipeline based on the condition.
         * Post conditions run in order regardless of their place in pipeline
         * 1. always - always run
         * 2. changed - run if something changed from last run
         * 3. aborted, success, unstable or failure - depending on status
         */
        always {
            echo "I AM ALWAYS first"
            sh 'docker system prune --all --force --volumes'
            // sh 'docker rmi $(docker images -q -f dangling=true)'
        }

        // intergrating with assyst for change control
        changed {
            echo "CHANGED is run second"
        }
        aborted {
            echo "SUCCESS, FAILURE, UNSTABLE, or ABORTED are exclusive of each other"
        }
        success {
            echo "SUCCESS, FAILURE, UNSTABLE, or ABORTED runs last"
        }
        unstable {
            echo "SUCCESS, FAILURE, UNSTABLE, or ABORTED runs last"
        }
        failure {
            echo "SUCCESS, FAILURE, UNSTABLE, or ABORTED runs last"
        }
        cleanup {
            cleanWs() // clean the current workspace
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
                script{
                    getrepo = sh(returnStdout: true, script: "basename -s .git `git config --get remote.origin.url`" ).trim()
//getrepo = sh "basename `git rev-parse --show-toplevel`"
                }

                echo "$getrepo"

            }
        }
        stage('Push to PCF') {
            steps {
                script {
                    //  node {
                echo "push"

                        //       }
                    }
                }
            }
        }
    }




