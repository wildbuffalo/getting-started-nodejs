pipeline {
     // git branch: 'develop', credentialsId: 'GitHub', url: 'https://github.com/wildbuffalo/dealworks-graphql-service.git'

    agent {

      docker {
          image 'merrillcorporation/docker-cicd-node'
          args '-p 3000:3000'
       }   
      }
    stages {
        stage('echo path') {
            steps('echo') {
                sh 'pwd'
                sh 'printenv'
                }
            }
        stage('Example Build') {
            steps('install'){
                sh 'npm install'
            
                }
            }
        stage('Test') {
            steps('install'){
                sh 'npm run test'
                }
            }
        stage('Static Analysis'){
            steps('Sonar'){
              sh "sonar-scanner \
                -Dsonar.projectKey=graphql \
                -Dsonar.sources=. \
                -Dsonar.host.url=http://10.68.17.183:9000 \
                -Dsonar.login=72d9aeef37d1eed4261b522b1055a2b9543e228a"
            }
        }
      
           }

   }
