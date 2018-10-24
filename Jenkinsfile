pipeline {
    agent any
    environment {
        JFROG=credentials("mrll-artifactory")
        CF_DOCKER_PASSWORD="$JFROG_PSW"
    }
    options {
        skipDefaultCheckout()
        ansiColor('xterm')
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


            cleanWs()
            //deleteDir()

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
    }
    stages {

        stage('Checkout') {
            //  agent any
            steps {
                checkout scm
                script {
                    gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                    //shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()

                }
            }
        }
//        stage('Build') {
//            steps {
//                script {
//
//                    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
//                        def dockerfile = 'Dockerfile'
//                        docker_image = docker.build("node/master:${gitCommit}", "-f ${dockerfile} .")
//                        /* Push the container to the custom Registry */
//                        docker_image.inside {
//                            sh 'printenv'
//                            sh 'ls'
//
//                        }
//                    }
//                }
//            }
//        }
//        stage('Test') {
//            steps {
//                script {
////                        def node = docker.build("node:${env.BUILD_ID}","./Docker/Dockerfile")
//
//                    docker_image.inside {
////                        sh 'cd /usr/src/app && npm test'
//                        sh 'printenv'
//                        sh 'ls'
//                        sh 'pwd'
//
//                    }
//                }
//            }
//        }
//
//        stage('Static Analysis') {
//            steps {
//                script {
//                    //      node {
//
//                    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
//
//                        docker.image('tools/sonar_scanner').inside() {
//                            sh 'ls'
//                            sh 'pwd'
//                            sh 'printenv'
//                            sh "sonar-scanner \
//                                -Dsonar.projectKey=dealworks_tryout \
//                                -Dsonar.sources=. \
//                                -Dsonar.exclusions='test/**, node_modules/**' \
//                                -Dsonar.host.url=https://sonarqube.devtools.merrillcorp.com \
//                                -Dsonar.login=c9b66ea7ea641c404bde3abf67747f46f458b623"
//                        }
//                        //       }
//                    }
//                }
//            }
//        }
//        stage('Push to Artifactory') {
//            steps {
//                script {
//
//                    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
//
////                  def node = docker.build("node:${env.BUILD_ID}","./Docker/Dockerfile")
//
//                        /* Push the container to the custom Registry */
//                        docker_image.inside {
//                            sh 'ls'
//                            sh 'printenv'
//                        }
//                        docker_image.push()
//                        docker_image.push('latest')
//
//                    }
//
//
//                }
//            }
//        }
        stage('Push to PCF') {
            steps {
                script {
                    //  node {

                    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

                        docker.image('tools/pcf_cli:latest').inside() {
                            sh 'ls'
                            sh 'printenv'
                            sh 'cf -v'
                            withCredentials([usernamePassword(credentialsId: 'PCF', passwordVariable: 'PCF_PW', usernameVariable: 'PCF_UN')]) {
                                sh "cf login -a https://api.sys.us2.devg.foundry.mrll.com -u $PCF_UN -p $PCF_PW -s devg"
                                sh "cf set-env -e APPDYNAMICS_CONTROLLER_HOST_NAME='merrill.saas.appdynamics.com' \
                                    APPDYNAMICS_CONTROLLER_PORT=443 \
                                    APPDYNAMICS_CONTROLLER_SSL_ENABLED=true \
                                    APPDYNAMICS_AGENT_ACCOUNT_NAME=Merrill \
                                    APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY=02de081213da "
                                sh "cf blue-green-deploy dealworks-tryout-app -f ./manifest.yml"

                            }

                        }
                        //       }
                    }
                }
            }
        }
    }
}

