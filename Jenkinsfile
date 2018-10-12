//pipeline {
//    // git branch: 'develop', credentialsId: 'GitHub', url: 'https://github.com/wildbuffalo/dealworks-graphql-service.git'
//    parameters {
//        booleanParam(defaultValue: true, description: '', name: 'booleanExample')
//        string(defaultValue: "TEST", description: 'What environment?', name: 'stringExample')
//        text(defaultValue: "This is a multiline\n text", description: "Multiline Text", name: "textExample")
//        choice(choices: 'US-EAST-1\nUS-WEST-2', description: 'What AWS region?', name: 'choiceExample')
//        password(defaultValue: "Password", description: "Password Parameter", name: "passwordExample")
//
//        string(defaultValue: "3.0.3.778", description: '', name: 'SONAR_SCANNER_VERSION')
//    }
//    agent none
//    stages {
//        stage('Static Analysis'){
//
//    }
//
//}


pipeline {
    agent none
    environment {
        JFROG=credentials("mrll-artifactory")
        CF_DOCKER_PASSWORD="$JFROG_PSW"
    }
    options {
        skipDefaultCheckout()
        ansiColor('xterm')
    }
    stages {

        stage('Checkout') {
            agent any
            steps {
                checkout scm
                // stash name:'scm', includes:'*'
                //   stash(name: 'ws', includes: '**')
            }
        }
        stage('Build and Push') {
            steps {
                script {

                    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

                        def dockerfile = 'Dockerfile'
                        docker_image = docker.build("node/master:${env.BUILD_ID}", "-f ${dockerfile} .")

                        /* Push the container to the custom Registry */
                        docker_image.inside {
                            sh 'printenv'
                        }
                    }


                }
            }
        }
        stage('Test') {
            steps {
                script {
//                        def node = docker.build("node:${env.BUILD_ID}","./Docker/Dockerfile")

                    docker_image.inside {
//                        sh 'cd /usr/src/app && npm test'
                        sh 'printenv'
                        sh 'ls'
                        sh 'pwd'

                    }
                }
            }
        }

        stage('Static Analysis') {
            steps {
                script {
                    node {

                        docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

                            docker.image('tools/sonarqube_scanner').inside('-u root:root') {
                                sh 'ls'
                                sh 'pwd'
                                sh 'printenv'
                                sh "sonar-scanner \
                                -Dsonar.projectKey=dealworks_tryout \
                                -Dsonar.sources=. \
                                -Dsonar.exclusions='test/**, node_modules/**' \
                                -Dsonar.host.url=https://sonarqube.devtools.merrillcorp.com \
                                -Dsonar.login=c9b66ea7ea641c404bde3abf67747f46f458b623"
                            }
                        }
                    }
                }
            }
        }
        stage('Push to Artifactory') {
            steps {
                script {

                    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

//                  def node = docker.build("node:${env.BUILD_ID}","./Docker/Dockerfile")

                        /* Push the container to the custom Registry */
                        docker_image.inside {
                            sh 'printenv'
                        }
                      //  docker_image.push()
                       // docker_image.push('latest')
                        docker_image.dockerPushStep()
                    }


                }
            }
        }
        stage('Push to PCF') {
            steps {
                script {
                    node {

                        docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

                            docker.image('tools/pcf_cli').inside('-u root:root') {
                                sh 'ls'
                                sh 'printenv'
                                sh 'cf -v'
                                withCredentials([usernamePassword(credentialsId: 'PCF', passwordVariable: 'PCF_PW', usernameVariable: 'PCF_UN'), usernamePassword(credentialsId: 'mrll-artifactory', passwordVariable: 'JFROG_PW', usernameVariable: 'JFROG_UN')]) {
                                    sh "cf login -a https://api.sys.us2.devg.foundry.mrll.com -u $PCF_UN -p $PCF_PW -s devg"
                                    sh "cf blue-green-deploy dealworks-tryout-app -f ./manifest.yml"

                                }


                            }
                        }
                    }
                }
            }
        }
    }
}

