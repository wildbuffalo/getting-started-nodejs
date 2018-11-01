FROM merrillcorp-dealworks.jfrog.io/node/master:latest as source

FROM merrillcorp-dealworks.jfrog.io/tools:latest  
COPY --from=source /usr/src/app/ /home/jenkins/src/
