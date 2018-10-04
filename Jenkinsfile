pipeline {
    agent none
    stages {
        stage('Example Build') {
            agent { docker 'maven:3-alpine' }
            steps {
                echo 'Hello, Maven'
                sh 'mvn --version'
            }
        }
        stage('Example Test') {
            agent { docker 'openjdk:8-jre' }
            steps {
                echo 'Hello, JDK'
                sh 'java -version'
            }
        }
        stage('Private Registry') {
            steps{
                
            docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

                def customImage = docker.build("node:${env.BUILD_ID}")

                /* Push the container to the custom Registry */
                customImage.push()
            }
            }
        }
    }
}

//
//        stage('Test image') {
//            /* Ideally, we would run a test framework against our image.
//             * For this example, we're using a Volkswagen-type approach ;-) */
//
//            app.inside {
//                sh 'echo "Tests passed"'
//
//            }
//        }
//        stage('Static Analysis') {
//            /* Ideally, we would run a test framework against our image.
//             * For this example, we're using a Volkswagen-type approach ;-) */
//
//            app.inside {
//                sh 'echo "Sonar"'
//                sh "sonar-scanner \
//                -Dsonar.projectKey=graphql \
//                -Dsonar.sources=. \
//                -Dsonar.host.url=http://10.68.17.183:9000 \
//                -Dsonar.login=72d9aeef37d1eed4261b522b1055a2b9543e228a"
//            }
//        }
//
//        stage('Push image') {
//            /* Finally, we'll push the image with two tags:
//             * First, the incremental build number from Jenkins
//             * Second, the 'latest' tag.
//             * Pushing multiple tags is cheap, as all the layers are reused. */
//            steps{
//                sh 'echo "printenv"'
//            }
//        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
//            app.push("${env.BUILD_NUMBER}")
//            app.push("latest")
//        }
//}
//
//}
