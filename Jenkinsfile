

node {
    checkout scm
    environment {
       JFROG=credentials("mrll-artifactory")
        //CF_DOCKER_PASSWORD="$JFROG_PSW"
    }
//    withDockerRegistry(credentialsId: 'mrll-artifactory', url: 'https://merrillcorp-dealworks.jfrog.io') {
//        //      def customImage = docker.build("node:${env.BUILD_ID}")
//        def customImage = docker.build("feirenliu/node:10-alpine")
//        /* Push the container to the custom Registry */
//        customImage.push()
//
//
//
//    }
  //  def rtDocker = Artifactory.docker username:$JFROG_USN , password:$JFROG_PSW
    // Step 1: Obtain an Artifactiry instance, configured in Manage Jenkins --> Configure System:
    def server = Artifactory.server 'JFROG'

    // Step 2: Create an Artifactory Docker instance:
    def rtDocker = Artifactory.docker server: server
    // Or if the docker daemon is configured to use a TCP connection:
    // def rtDocker = Artifactory.docker server: server, host: "tcp://<docker daemon host>:<docker daemon port>"
    // If your agent is running on OSX:
    // def rtDocker= Artifactory.docker server: server, host: "tcp://127.0.0.1:1234"
 //   dockerPullStep()
  //  echo("$server")
 //   echo("$rtDocker")
    // Step 3: Push the image to Artifactory.
    // Make sure that <artifactoryDockerRegistry> is configured to reference <targetRepo> Artifactory repository. In case it references a different repository, your build will fail with "Could not find manifest.json in Artifactory..." following the push.
    DockerPullStep("merrillcorp-dealworks.jfrog.io/hello-world:latest","$JFROG","https://merrillcorp.jfrog.io")
    
    //def buildInfo = rtDocker.pull 'hello-world:latest', 'dealworks'

    // Step 4: Publish the build-info to Artifactory:
    //server.publishBuildInfo buildInfo
}

//node {
//    checkout scm
//
//    withDockerRegistry(credentialsId: 'docker-hub-feirenliu', url: '') {
//        //      def customImage = docker.build("node:${env.BUILD_ID}")
//        def customImage = docker.build("feirenliu/node:10-alpine")
//        /* Push the container to the custom Registry */
//        customImage.push()
//
//
//
//    }
//}
//pipeline {
//    environment {
//        registry = 'https://hub.docker.com'
//        registryCredential = 'docker-hub-feirenliu'
//        dockerImage = 'node:10-alpine'
//    }
//    agent any
////    tools {nodejs "node" }
//    stages {
//        stage('Cloning Git') {
//            steps {
//                git branch: 'jfrog', url: 'https://github.com/wildbuffalo/getting-started-nodejs.git'
//
//            }
//        }
//        stage('Build') {
//            steps {
//                sh 'npm install'
//                sh 'npm run bowerInstall'
//            }
//        }
//        stage('Test') {
//            steps {
//                sh 'npm test'
//            }
//        }
//        stage('Building image') {
//            steps{
//                script {
//                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
//                }
//            }
//        }
//        stage('Deploy Image') {
//            steps{
//                script {
//                    docker.withRegistry( registry , registryCredential ) {
//                        dockerImage.push()
//                    }
//                }
//            }
//        }
//    }
//}
