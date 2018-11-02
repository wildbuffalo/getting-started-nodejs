pipeline {
    agent any
    environment {
        JFROG=credentials("mrll-artifactory")
        CF_DOCKER_PASSWORD="$JFROG_PSW"
        PCF=credentials("svc-inf-jenkins")
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



    }

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
        cleanup{
                cleanWs()
                dir("${env.WORKSPACE}@tmp") {
                cleanWs()
                }
                node ('slave') {
                // do useful build things first
                cleanWs() // clean up workspace on slave
                }
                // node ('master') {
                // dir("${env.WORKSPACE}@libs") {
                //     deleteDir()
                // }
                // dir("${env.WORKSPACE}@script") {
                // deleteDir()
                // }
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
       stage('Build') {
           steps {
               script {

                   docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
                       def dockerfile = './Docker/Dockerfile'
                       docker_image = docker.build("node/master:${gitCommit}", "-f ${dockerfile} .")
                       /* Push the container to the custom Registry */
                       docker_image.inside {
                           sh 'printenv'
                           sh 'ls'
                           sh 'npm -v'
                           sh 'npm install'

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
                   //      node {

                   docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

                       docker.image('tools/sonar_scanner').inside() {
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
                       //       }
                   }
               }
           }
       }
        stage('Push to Artifactory') {
        steps {
            script {

                docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

                    docker_image.inside {
                        sh 'ls'
                        sh 'printenv'
                    }
                    docker_image.push()
                    docker_image.push('latest')

                }


            }
        }
        }

       stage('Push to PCF') {
           steps {
               script {
                   //  node {

                   docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
                       def dockerfile = './Docker/pcf.Dockerfile'
                       docker_pcf_src = docker.build("docker_pcf_src", "-f ${dockerfile} .")
                       docker_pcf_src.inside() {
                                // sh 'cd /home/jenkins/src'
                                sh 'ls'
                                sh 'pwd'
                                sh 'printenv'
                                sh 'cf -v'
                                withCredentials([usernamePassword(credentialsId: 'PCF', passwordVariable: 'PCF_PW', usernameVariable: 'PCF_UN')]) {
                                    sh "cd /home/jenkins/src &&\
                                        ls &&\
                                        cf login -a https://api.sys.us2.devg.foundry.mrll.com -u $PCF_UN -p $PCF_PW -s devg &&\
                                        cf blue-green-deploy dealworks-tryout-app -f ./manifest.yml --delete-old-apps"

                                }
                       }
                       //       }
                   }
               }
           }
       }
    }
}


//        stage('Push to Artifactory') {
//            steps {
//                script {

//                    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

//                        docker.image('tools:latest').inside() {
//                            sh 'jfrog --version'
//                            sh "jfrog rt config --user=$JFROG_USR \
//                                     --password=$JFROG_PSW \
//                                     --url=https://merrillcorp.jfrog.io/merrillcorp \
//                                     --interactive=false rt_admin"
//                            sh "jfrog rt npmp npm-virtual --build-name=dealworks-app --build-number=${gitCommit}"
// //                          sh "jfrog rt npmp \
// //                                --server-id=rt_admin \
// //                                --build-number ${gitCommit} \
// //                                --build-name dealworks-app"
// //                          sh "jfrog rt npmp --url https://merrillcorp.jfrog.io/merrillcorp/api/npm/dealworks-src/ \
// //                                --user $JFROG_USR \
// //                                --password $JFROG_PSW \
// //                                --build-number ${gitCommit} \
// //                                --build-name dealworks-app"
//                            sh 'ls'
//                            sh 'printenv'
//                        }

//                    }
//                }
//            }
//        }