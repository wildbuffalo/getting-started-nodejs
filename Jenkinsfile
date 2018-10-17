pipeline {
    environment {
        REL_VERSION = "${BRANCH_NAME.contains('release-') ? BRANCH_NAME.drop(BRANCH_NAME.lastIndexOf('-')+1) + '.' + BUILD_NUMBER : ""}"

    }
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
                stash name:'scm', includes:'*'
                //   stash(name: 'ws', includes: '**')
            }
        }
        stage('Static Analysis') {
            steps {
                script {
                    node {

                        docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

                            docker.image('tools/sonar_scanner:latest').inside() {
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
    }

}
