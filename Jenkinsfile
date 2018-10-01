node {
    def app
    def sonar



    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build('node:10-alpine')
        sonar = docke.build('newtmitch/sonar-scanner:3.2.0-alpine')
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'echo "Tests passed"'

        }
    }
    stage('Static Analysis') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'echo "Sonar"'
            sh "sonar-scanner \
                -Dsonar.projectKey=graphql \
                -Dsonar.sources=. \
                -Dsonar.host.url=http://10.68.17.183:9000 \
                -Dsonar.login=72d9aeef37d1eed4261b522b1055a2b9543e228a"
        }
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        steps{
            sh 'echo "printenv"'
        }
//        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
//            app.push("${env.BUILD_NUMBER}")
//            app.push("latest")
    }
}

