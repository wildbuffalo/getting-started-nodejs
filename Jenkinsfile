node {
    checkout scm 
    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {

                        
    docker.image(mysql:5).withRun() { c ->
        docker.image('node:10-alpine').inside("--link ${c.id}:node") {
            /* Wait until mysql service is up */
            sh 'node -v'
            
        }
        docker.image('tools/sonar_scanner').inside("--link ${c.id}:node") {
            /*
             * Run some tests which require MySQL, and assume that it is
             * available on the host name `db`
             */
            sh 'sonar-scanner -v'
             sh 'while ! mysqladmin ping -hdb --silent; do sleep 1; done'
                
        }}
    }
}
