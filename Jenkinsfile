pipeline {
    agent none

    options {
        skipDefaultCheckout()
        ansiColor('xterm')
    }
//    post{
    //       always {
    //           echo 'One way or another, I have finished'
    //           deleteDir() /* clean up our workspace */
    //       }
    // }//Post: notifications; hipchat, slack, send email etc.
    stages {
        stage('Checkout') {
            agent any
            steps {
                checkout scm
                //   stash(name: 'ws', includes: '**')
            }
        }

        stage('Deploy') {
            agent {
                withDockerRegistry([credentialsId:'mrll-artifactory', url:'https://merrillcorp-dealworks.jfrog.io'] )  {
                    image 'tools/sonar_scanner:latest'
                    // args '-v $WORKSPACE:/project'
                    // reuseNode true
                }
            }
            steps {
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
//    stage('Static Analysis') {
//        steps {
//            script {
//                node {
//
//                    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
//
//                        docker.image('tools/sonar_scanner:latest').inside('-u jenkins:jenkins') {
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
//                    }
//                }
//            }
//        }
//    }
//}

}
