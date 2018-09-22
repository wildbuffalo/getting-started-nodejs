pipeline {
     // git branch: 'develop', credentialsId: 'GitHub', url: 'https://github.com/wildbuffalo/dealworks-graphql-service.git'
    parameters {
        booleanParam(defaultValue: true, description: '', name: 'booleanExample')
        string(defaultValue: "TEST", description: 'What environment?', name: 'stringExample')
        text(defaultValue: "This is a multiline\n text", description: "Multiline Text", name: "textExample")
        choice(choices: 'US-EAST-1\nUS-WEST-2', description: 'What AWS region?', name: 'choiceExample')
        password(defaultValue: "Password", description: "Password Parameter", name: "passwordExample")
        
        string(defaultValue: "3.0.3.778", description: '', name: 'SONAR_SCANNER_VERSION')
    }
     agent none
    stages {

        stage('echo path') {
            steps('echo') {
                sh 'pwd'
                sh 'printenv'
                }
            }
        stage('Build/Test') {
          agent { docker { image 'node:10-alpine' }}
            steps('install'){
                sh 'npm install'
            
                }
            
      
            steps('Test'){
                sh 'npm run test'
            }

      
           }
     
        stage('Static Analysis'){
             agent { docker 'newtmitch/sonar-scanner:3.2.0-alpine' }
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

