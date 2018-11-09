//node {
//    checkout scm
//    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
//
//
//        docker.image('mysql:5').withRun('-e "MYSQL_ROOT_PASSWORD=my-secret-pw"') { c ->
//            docker.image('node:10-alpine').inside("--link ${c.id}:node") {
//                /* Wait until mysql service is up */
//                sh 'node -v'
//
//            }
//            docker.image('tools/sonar_scanner').inside("--link ${c.id}:node") {
//                /*
//                 * Run some tests which require MySQL, and assume that it is
//                 * available on the host name `db`
//                 */
//                sh 'sonar-scanner -v'
//                sh 'while ! mysqladmin ping -hdb --silent; do sleep 1; done'
//
//            }}
//    }
//}
pipeline {
    agent any

    environment {
        JFROG=credentials("mrll-artifactory")
        CF_DOCKER_PASSWORD="$JFROG_PSW"
        PCF=credentials("svc-inf-jenkins")
        repoName="dealworks_tryout_app"
    }
    options {
        skipDefaultCheckout()
        ansiColor('xterm')
    }
    parameters {
        string(name: 'REPO', defaultValue: 'dealworks_tryout_app')
        string(name: 'SRC_PATH', defaultValue: 'mrll-npm/@mrll/dealworks-app/-/@mrll/dealworks-app-1.0.294.tgz')

        // booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')

        choice(name: 'Space', choices: ['devg', 'stageg', 'prod'], description: 'PCF spaces')

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
//                sh "curl -u $JFROG_USR:$JFROG_PSW -o ./archive.tgz -L https://merrillcorp.jfrog.io/merrillcorp/${params.SRC_PATH} --fail -O"
//                sh 'mkdir archive'
//                sh "tar -xvf archive.tgz -C archive"
//                sh "ls"
//                sh 'ls archive'
//                stash includes: 'archive/package/*', name: 'app'
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
//                            dir("first-stash"){
//                                unstash 'app'
//                            }
                            //   unstash 'app'

                            sh 'ls'
                            sh 'pwd'
                            sh 'printenv'
                            sh 'cf -v'
//                            sh "cd ${pwd()}/first-stash/archive/package/ &&\
//                                        ls &&\
//                                        cf login -a https://api.sys.us2.devg.foundry.mrll.com -u $PCF_USR -p $PCF_PSW -s devg &&\
//                                        cf blue-green-deploy ${params.REPO} -f ${pwd()}/pcf/manifest-dev.yml --delete-old-apps"
//"cd /home/jenkins/src &&\
                            sh "ls &&\
                                        cf login -a https://api.sys.us2.devg.foundry.mrll.com -u $PCF_USR -p $PCF_PSW -s devg &&\
                                        cf blue-green-deploy $repoName -f ./manifest.yml --delete-old-apps"

                        }
                        //       }
                    }
                }
            }
        }
    }
}

