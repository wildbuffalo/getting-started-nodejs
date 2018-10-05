pipeline {
    agent none
    stages {
        stage('Example Build') {
            agent { docker 'node:10-alpine' }
            steps {
                echo 'Hello, Maven'
                sh 'npm install'
            }
        }
        stage('Build and Push') {
            steps {
                script {
                    node {
                        docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

                            def dockerfile = 'docker/Dockerfile'
                            def node = docker.build("node:${env.BUILD_ID}", "-f ${dockerfile}")
//                        def node = docker.build("node:${env.BUILD_ID}","./Docker/Dockerfile")

                            /* Push the container to the custom Registry */
                            node.inside {
                                sh 'printenv'
                            }
                        }

                    }
                }
            }
        }
        stage('Example Test') {
            steps {
                script {
                    node {

                            node.inside {
                                    sh 'ls'
                                h 'printenv'
                            }
                        }

                    }
                }
            }
        
//        stage('Static Analysis') {
//            steps {
//                script {
//                    node {
//
//                        docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
//
//                            docker.image('tools/sonarqube_scanner').inside('-u root:root') {
//                                sh 'ls'
//                                sh 'printenv'
//                                sh "sonar-scanner \
//                                -Dsonar.projectKey=dealworks_tryout \
//                                -Dsonar.sources=. \
//                                -Dsonar.host.url=https://sonarqube.devtools.merrillcorp.com \
//                                -Dsonar.login=c9b66ea7ea641c404bde3abf67747f46f458b623"
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        stage('Push to Artifactory') {
//            steps {
//                script {
//                    node {
//
//                        docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
//
//                            def customImage = docker.build("node:${env.BUILD_ID}")
//
//                            /* Push the container to the custom Registry */
//                            customImage.push()
//                            customImage.push('latest')
//                        }
//                    }
//                }
//            }
//        }
//        stage('Push to PCF') {
//            steps {
//                script {
//                    node {
//
//                        docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
//
//                            docker.image('tools/pcf_cli').inside() {
//                                sh 'ls'
//                                sh 'printenv'
//                                sh "cf blue-green-deploy dealworks-tryout-app -f .manifest.yml"
//                            }
//                        }
//                    }
//                }
//            }
//        }
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
