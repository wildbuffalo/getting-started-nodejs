pipeline {
    environment {
        REL_VERSION = "${BRANCH_NAME.contains('release-') ? BRANCH_NAME.drop(BRANCH_NAME.lastIndexOf('-')+1) + '.' + BUILD_NUMBER : ""}"
    }
    agent none
//    options {
//        skipDefaultCheckout()
//    }
    stages {
//        stage('Checkout') {
//            agent any
//            steps {
//                checkout scm
//                stash(name: 'ws', includes: '**')
//            }
//        }
        stage('Build') {
            steps{
                script {
                    node {
                        docker.image('node:10-alpine').inside('-v $PWD:/src/') {

                            sh 'npm install'
                        }
                    }
                }
            }

//            agent {
//                docker {
//                    image 'node:10-alpine'
//                    args '-v $PWD:/src'
//
//                }
//            }
//            steps {
////                unstash 'ws'
//                sh 'npm install'
////                stash name: 'war', includes: 'module/**/*'
//            }
////            post {
////                success {
////                    sh 'printenv'
////                    archive '**/*.zip'
////                }
////            }
        }
        stage('Test Backend') {
            steps{
                script {
                    node {
                        docker.image('node:10-alpine').inside('-v $PWD:/src/') {

                            sh 'npm test'
                        }
                    }
                }
            }
//            agent {
//                docker {
//                    image 'node:10-alpine'
//                    arg
//
//                }
//            }
//            steps {
////                unstash 'ws'
////                unstash 'war'
//                sh 'npm test'
//            }
            post {
                success {
                    sh 'echo success'
                    //                 junit '**/surefire-reports/**/*.xml'
                    //                 findbugs pattern: 'target/**/findbugsXml.xml', unstableNewAll: '0' //unstableTotalAll: '0'
                }
                unstable {
                    sh 'echo unstable'
                    //                 junit '**/surefire-reports/**/*.xml'
                    //                 findbugs pattern: 'target/**/findbugsXml.xml', unstableNewAll: '0' //unstableTotalAll: '0'
                }
            }
        }
//        stage('Test More') {
//            agent none
//            when {
//                anyOf {
//                    branch "master"
//                    branch "release-*"
//                }
//            }
//            steps {
//                parallel(
//                        'Frontend' : {
//                            script {
//                                node {
//                                    unstash 'ws'
//                                    sh 'echo hello'
//                                    //sh 'gulp test'
//                                    //                      sh './frontEndTests.sh'
//                                }
//                            }
//                        },
//                        'Performance' : {
//                            script {
//                                node {
//                                    docker.image('maven:3-alpine').inside('-v $HOME/.m2:/root/.m2') {
//                                        unstash 'ws'
//                                        unstash 'war'
//                                        sh './mvnw -B gatling:execute'
//                                    }
//                                }
//                            }
//                        })
//            }
//        }
//        stage('Deploy to Staging') {
//            agent any
//            environment {
//                STAGING_AUTH = credentials('staging')
//            }
//            when {
//                anyOf {
//                    branch "master"
//                    branch "release-*"
//                }
//            }
//            steps {
//                unstash 'war'
//                sh './deploy.sh staging -v $REL_VERSION -u $STAGING_AUTH_USR -p $STAGING_AUTH_PSW'
//            }
//            //Post: Send notifications; hipchat, slack, send email etc.
//        }
//        stage('Archive') {
//            agent any
//            when {
//                not {
//                    anyOf {
//                        branch "master"
//                        branch "release-*"
//                    }
//                }
//            }
//            steps {
//                unstash 'war'
//                archiveArtifacts artifacts: 'target/**/*.war', fingerprint: true, allowEmptyArchive: true
//            }
//        }
//        stage('Deploy to production') {
//            agent any
//            environment {
//                PROD_AUTH = credentials('production')
//            }
//            when {
//                branch "release-*"
//            }
//            steps {
//                timeout(15) {
//                    input message: 'Deploy to production?', ok: 'Fire zee missiles!'
//                    unstash 'war'
//                    sh './deploy.sh production -v $REL_VERSION -u $PROD_AUTH_USR -p $PROD_AUTH_PSW'
//                }
//            }
//        }
    }
    //Post: notifications; hipchat, slack, send email etc.
}
