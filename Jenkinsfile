

pipeline {
    agent none
    environment {
        JFROG = credentials("mrll-artifactory")
        //CF_DOCKER_PASSWORD="$JFROG_PSW"
    }
//    withDockerRegistry(credentialsId: 'mrll-artifactory', url: 'https://merrillcorp-dealworks.jfrog.io') {
////        //      def customImage = docker.build("node:${env.BUILD_ID}")
//        def customImage = docker.build("feirenliu/node:10-alpine")
////        /* Push the container to the custom Registry */
//
//
//    }

    stages {

        stage('Build and Push') {
            steps {
                script {

                    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

                        def dockerfile = 'Dockerfile'
                        docker_image = docker.build("node/master:${env.BUILD_ID}", "-f ${dockerfile} .")

                        /* Push the container to the custom Registry */
                        docker_image.inside {
                            sh 'printenv'
                        }
                    }


                }
            }
        }

        stage('Push') {
            steps{
                script {
                    //  def rtDocker = Artifactory.docker username:$JFROG_USN , password:$JFROG_PSW
                    // Step 1: Obtain an Artifactiry instance, configured in Manage Jenkins --> Configure System:
                    def server = Artifactory.server 'JFROG'

                    // Step 2: Create an Artifactory Docker instance:
                    def rtDocker = Artifactory.docker server: server

//            def artDocker = Artifactory.docker("$JFROG_USR", "$JFROG_PSW")
                    def dockerInfo = rtDocker.push("merrillcorp-dealworks.jfrog.io/node/master:${env.BUILD_ID}", "dealworks")
                    buildInfo.append(dockerInfo)

//            
//            def dockerfile = 'Dockerfile'
//            rtDocker.build("node/master:${env.BUILD_ID}", "-f ${dockerfile} .")
                    // def rtDocker = Artifactory.docker username: "$JFROG_USR", password: "$JFROG_PSW"
                    // Step 3: Push the image to Artifactory.
                    // Make sure that <artifactoryDockerRegistry> is configured to reference <targetRepo> Artifactory repository. In case it references a different repository, your build will fail with "Could not find manifest.json in Artifactory..." following the push.
                    // DockerPullStep("merrillcorp-dealworks.jfrog.io/hello-world:latest","$JFROG","https://merrillcorp.jfrog.io")
                    //  docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory'){
                    //     DockerPullStep("merrillcorp-dealworks.jfrog.io/hello-world:latest")
//            rtDocker.push("merrillcorp-dealworks.jfrog.io/node:latest", "dealworks")

                    //   }
                    // Step 4: Publish the build-info to Artifactory:
                    server.publishBuildInfo buildInfo
                }
            }

        }
    }
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
