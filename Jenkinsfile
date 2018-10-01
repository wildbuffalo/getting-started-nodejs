//node {
//    def app
//
//    stage('Clone repository') {
//        /* Let's make sure we have the repository cloned to our workspace */
//
//        git branch: 'jfrog', url: 'https://github.com/wildbuffalo/getting-started-nodejs.git'
//    }
//
//    stage('Build image') {
//        /* This builds the actual image; synonymous to
//         * docker build on the command line */
//
//        app = docker.build("node:10-alpine")
//    }
//
//    stage('Test image') {
//        /* Ideally, we would run a test framework against our image.
//         * For this example, we're using a Volkswagen-type approach ;-) */
//
//        app.inside {
//            sh 'echo "Tests passed"'
//        }
//    }
//
//    stage('Push image') {
//        /* Finally, we'll push the image with two tags:
//         * First, the incremental build number from Jenkins
//         * Second, the 'latest' tag.
//         * Pushing multiple tags is cheap, as all the layers are reused. */
//        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-feirenliu') {
//            app.push("${env.BUILD_NUMBER}")
//            app.push("latest")
//        }
//    }
//}
pipeline {
    environment {
        registry = “https://hub.docker.com”
        registryCredential = ‘docker-hub-feirenliu’
        dockerImage = ‘node:10-alpine’
    }
    agent any
//    tools {nodejs “node” }
    stages {
        stage(‘Cloning Git’) {
            steps {
                git branch: 'jfrog', url: 'https://github.com/wildbuffalo/getting-started-nodejs.git'

            }
        }
        stage(‘Build’) {
            steps {
                sh ‘npm install’
                sh ‘npm run bowerInstall’
            }
        }
        stage(‘Test’) {
            steps {
                sh ‘npm test’
            }
        }
        stage(‘Building image’) {
            steps{
                script {
                    dockerImage = docker.build registry + “:$BUILD_NUMBER”
                }
            }
        }
        stage(‘Deploy Image’) {
            steps{
                script {
                    docker.withRegistry( registry , registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
