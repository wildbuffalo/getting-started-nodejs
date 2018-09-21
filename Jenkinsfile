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
   // agent {

         docker.withRegistry('https://registry.example.com') {

             docker.image('node:10-alpine').inside {
                 sh "apt-get update && apt-get install -y --no-install-recommends \
                   unzip && \
                   wget https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${params.SONAR_SCANNER_VERSION}-linux.zip && \
                   unzip sonar-scanner-cli-${params.SONAR_SCANNER_VERSION}-linux -d /usr/local/share/ && \
                   chown -R node: /usr/local/share/sonar-scanner-${params.SONAR_SCANNER_VERSION}-linux"
             }
         }
   //   }
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
