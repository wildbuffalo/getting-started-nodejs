FROM merrillcorp-dealworks.jfrog.io/scratch/master:latest as source

FROM merrillcorp-dealworks.jfrog.io/tools/pcf_cli:latest  
COPY --from=source /usr/src/app/ /home/jenkins/src/
