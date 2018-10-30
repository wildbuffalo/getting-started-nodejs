FROM ubuntu:xenial
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ENV JENKINS_HOME=/home/jenkins

RUN addgroup --gid ${gid} ${group} \
    && adduser --home ${JENKINS_HOME} --uid ${uid} --gid ${gid} --shell /bin/bash --disabled-password --gecos "" ${user}


RUN apt-get update && apt-get install -y git curl jq httpie wget apt-transport-https make && \
    apt-get clean

# install jfrog CLI
RUN curl -Lo /usr/bin/jfrog https://api.bintray.com/content/jfrog/jfrog-cli-go/\$latest/jfrog-cli-linux-amd64/jfrog?bt_package=jfrog-cli-linux-amd64 &&\
    chmod +x /usr/bin/jfrog && \
    # install PCF CLI
    wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - && \
    echo "deb http://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list && \
    apt-get update -y &&\
    apt-get install cf-cli -y &&\
    cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org  

# install nodejs 
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - &&\
    apt-get install -y nodejs
# &&\
# cf install-plugin -f blue-green-deploy -r CF-Community

USER jenkins
WORKDIR /home/jenkins/
COPY . .
RUN cf install-plugin -f blue-green-deploy -r CF-Community
# FROM ruby:2.5-alpine

# ENV PACKAGES "unzip curl openssl ca-certificates git libc6-compat bash"
# ENV CF_CLI_VERSION "6.34.1"
# ENV CF_BGD_VERSION "1.3.0"
# ENV CF_BGD_CHECKSUM "c74995ae0ba3ec9eded9c2a555e5984ba536d314cf9dc30013c872eb6b9d76b6"
# ENV CF_BGD_TEMPFILE "/tmp/blue-green-deploy.linux64"
# ENV CF_AUTOPILOT_VERSION "0.0.4"
# ENV CF_AUTOPILOT_CHECKSUM "a755f9da3981fb6dc6aa675a55f8fc7de9d73c87b8cad4883d98c543a45a9922"
# ENV CF_AUTOPILOT_TEMPFILE "/tmp/autopilot-linux"
# ENV SPRUCE_VERSION "1.17.0"

# RUN apk add --update $PACKAGES && rm -rf /var/cache/apk/*
# RUN ln -s /lib/ /lib64 # FIXME: Remove for Alpine >= 3.6

# RUN curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&version=${CF_CLI_VERSION}" | tar -zx -C /usr/local/bin
# RUN curl -L 'https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64' -o /usr/local/bin/jq && chmod +x /usr/local/bin/jq

# RUN curl -L -o "${CF_BGD_TEMPFILE}" \
#     "https://github.com/bluemixgaragelondon/cf-blue-green-deploy/releases/download/v${CF_BGD_VERSION}/blue-green-deploy.linux64" \
#     && echo "${CF_BGD_CHECKSUM}  ${CF_BGD_TEMPFILE}" | sha256sum -c - \
#     && chmod +x "${CF_BGD_TEMPFILE}" \
#     && cf install-plugin -f "${CF_BGD_TEMPFILE}" \
#     && rm "${CF_BGD_TEMPFILE}"

# RUN curl -L -o "${CF_AUTOPILOT_TEMPFILE}" \
#     "https://github.com/contraband/autopilot/releases/download/${CF_AUTOPILOT_VERSION}/autopilot-linux" \
#     && echo "${CF_AUTOPILOT_CHECKSUM}  ${CF_AUTOPILOT_TEMPFILE}" | sha256sum -c - \
#     && chmod +x "${CF_AUTOPILOT_TEMPFILE}" \
#     && cf install-plugin -f "${CF_AUTOPILOT_TEMPFILE}" \
#     && rm "${CF_AUTOPILOT_TEMPFILE}"

# RUN curl -Lo /usr/local/bin/spruce https://github.com/geofffranks/spruce/releases/download/v${SPRUCE_VERSION}/spruce-linux-amd64 \
#     && chmod +x /usr/local/bin/spruce

# jfrog rt config --user=svc-inf-jenkins \
#     --password='Hcrx2WYHO!o' \
#     --url=https://merrillcorp.jfrog.io/merrillcorp \
#     --interactive=false rt_admin

# jfrog rt npmp --user=svc-inf-jenkins --password='Hcrx2WYHO!o' --url=https://merrillcorp.jfrog.io/merrillcorp --build-name=docker_web_app --build-number=1.0.1 dealworks-src
# curl -o filename.tar.gz http://filename-4.0.1.tar.gz