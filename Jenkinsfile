@Library('ds1-marketing-jenkins-library@master') _
build_node_frontend{
    build = "npm install"
    test = "npm run test"
    sonar = "sonar-scanner \
            -Dsonar.host.url=https://sonarqube.devtools.merrillcorp.com"
}
