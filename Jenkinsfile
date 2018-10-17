pipeline {
    agent none

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
                script {
                node{
                 //   sh 'docker system prune --all --force --volumes'
                    sh 'docker rmi '$(docker images -q -f dangling=true)''
                }
                }
                deleteDir()
                
            }
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
            agent any
            steps {
                checkout scm
                //   stash(name: 'ws', includes: '**')
            }   
        }


    
    stage('Static Analysis') {
        steps {
            script {
                node {

                    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

                        sh 'make sonar'
                    }
                }
            }
        }
    }
}

}
