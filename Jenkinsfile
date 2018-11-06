node {
    checkout scm 
    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

                        
    docker.image('tools/sonar_scanner').withRun() { c ->
        docker.image('node:10-alpine').inside("--link ${c.id}:node") {
            /* Wait until mysql service is up */
            sh 'node -v'
            sh 'sonar-scanner -v'
        }
        docker.image('tools:latest').inside("--link ${c.id}:node") {
            /*
             * Run some tests which require MySQL, and assume that it is
             * available on the host name `db`
             */
            sh 'mcf -v'
                
        }}
    }
}
