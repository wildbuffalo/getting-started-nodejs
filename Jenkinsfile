//library 'ds1_marketing_jenkins_library@master' _
//@Library('ds1_marketing_jenkins_library@master') _

pipeline {
    agent any
    environment {
        JFROG=credentials("mrll-artifactory")
        CF_DOCKER_PASSWORD="$JFROG_PSW"
        PCF=credentials("svc-inf-jenkins")
        version="latest"

    }
    options {
        skipDefaultCheckout()
        disableConcurrentBuilds()
        //   ansiColor('xterm')
    }
    post {
        cleanup {
            // clean the current workspace
            cleanWs()
            // clean the @tmp workspace
            dir("${env.WORKSPACE}@tmp") {
                cleanWs()
            }
            node('master') {
                // clean the master @libs workspace
                dir("${env.WORKSPACE}@libs") {
                    cleanWs()
                }
                // clean the master @script workspace
                dir("${env.WORKSPACE}@script") {
                    cleanWs()
                }
            }
        }
    }

    stages {
        stage('Checkout') {
            //  agent any
            steps {
                checkout scm
                script {
                    env.gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                    env.getRepo = sh(returnStdout: true, script: "basename -s .git `git config --get remote.origin.url`").trim()
                    sh 'printenv'
                    pipline_stage ="123"


                }
            }

        }
        stage('Build') {
            steps {
                script {
//                    writeFile file: 'deploy.Dockerfile', text: "FROM merrillcorp-dealworks.jfrog.io/$getRepo/$version as source\n" +
//                            "FROM merrillcorp-dealworks.jfrog.io/tools:latest\n  " +
//                            "COPY --from=source /usr/src/app/ /home/jenkins/src/"
                    sh "echo $WORKSPACE"
                    sh "echo $env.WORKSPACE"
                    sh "echo $pipline_stage"
                    sh 'ls'
                    post_notification{}
                    deployment{
                        repo = $getRepo
                        dev_stage = $stage
                        repo_version = $version
                    }
                    sh 'ls'
                    sh 'cat deploy.Dockerfile'

//                    notification currentBuild.result
                }

            }
        }
    }
}
def test(body) {
    // evaluate the body block, and collect configuration into the object
    def config = [:]
    body.resolveStrategy = Closure.DELEGATE_FIRST
    body.delegate = config
    body()
    echo("$version")
    sh("echo $env.WORKSPACE")

}
def post_notification(body){
    // evaluate the body block, and collect configuration into the object
    def config = [:]
    body.resolveStrategy = Closure.DELEGATE_FIRST
    body.delegate = config
    body()
            echo("$pipline_stage")
            sh("echo $env.WORKSPACE")

}
def deployment(body) {
    // evaluate the body block, and collect configuration into the object
    def config = [:]
    body.resolveStrategy = Closure.DELEGATE_FIRST
    body.delegate = config
    body()
    getDockerfile(config.repo,config.dev_stage,config.repo_version)
    runDockerfile(config.repo,config.dev_stage)
//    getDockerfile()
//    runDockerfile()

}
//call("pp" ,'fff','hhh')
def getDockerfile(def repo, def stage, def version) {
//        filePath, getRepo,stage,version ->
//        new File(".",'deploy.Dockerfile') << "FROM merrillcorp-dealworks.jfrog.io/$getRepo/$stage:$version as source\n" +
//                "FROM merrillcorp-dealworks.jfrog.io/tools:latest\n" +
//                "COPY --from=source /usr/src/app/ /home/jenkins/src/\n"
    writeFile file: 'deploy.Dockerfile', text:"FROM merrillcorp-dealworks.jfrog.io/ds1-graphql-service/develop:latest as source\n" +
            "FROM merrillcorp-dealworks.jfrog.io/tools:latest\n" +
            "COPY --from=source /usr/src/app/ /home/jenkins/src/\n"
}

def runDockerfile(getRepo,stage){
    docker.withRegistry('https://merrillcorp-dealworks.jfrog.io', 'mrll-artifactory') {
        def dockerfile = "./deploy.Dockerfile"
        docker_pcf_src = docker.build("docker_pcf_src", "--pull -f ${dockerfile} .")
        docker_pcf_src.inside() {

                //            sh "cd /home/jenkins/src &&\
//                                        ls &&\
//                                        cf login -a https://api.sys.us2.prodg.foundry.mrll.com -u $PCF_USR -p $PCF_PSW &&\
//                                        pwd"
//                                        cf zero-downtime-push $getRepo-prod -f ./devops/manifest-prod.yml"
                if (stage == 'master' ) {
//                sh "cd /home/jenkins/src &&\
//                                        ls &&\
//                                        cf login -a https://api.sys.us2.prodg.foundry.mrll.com -u $PCF_USR -p $PCF_PSW &&\
//                                        pwd"
                    sh"echo ls"

                }else if (stage == 'stage' ){
//                sh "cd /home/jenkins/src &&\
//                                        ls &&\
//                                        cf login -a https://api.sys.us2.devg.foundry.mrll.com -u $PCF_USR -p $PCF_PSW -s stageg &&\
//                                        cf zero-downtime-push $getRepo-stage -f ./devops/manifest-stage.yml"
                }else {
//                sh "cd /home/jenkins/src &&\
//                                        ls &&\
//                                        cf login -a https://api.sys.us2.devg.foundry.mrll.com -u $PCF_USR -p $PCF_PSW -s devg &&\
//                                        pwd"

                }


        }
    }
}
