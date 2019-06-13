podTemplate(
    name: 'test-pod',
    label: 'test-pod',
    containers: [
        containerTemplate(name: 'golang', image: 'alpine/git:latest'),
        containerTemplate(name: 'docker', image:'docker'),
    ],
    volumes: [
        hostPathVolume(mountPath: '/var/run/docker.sock',
        hostPath: '/var/run/docker.sock',
    ],
    {
        //node = the pod label
        node('test-pod'){
            //container = the container label
            stage('Build'){
                container('golang'){
                    sh "git -v"
                }
            }
            stage('Build Docker Image'){
                container(‘docker’){
                    sh "docker -v"
                }
            }
        }
    })