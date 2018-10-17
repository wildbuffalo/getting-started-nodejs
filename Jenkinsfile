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
