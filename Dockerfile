FROM mrllus2cbacr.azurecr.io/dealworks/getting-started-nodejs/cloudbee:latest
# Create app directory
WORKDIR /usr/src/app

# RUN apk add --no-cache curl 

# RUN curl -o setup_agent.sh https://setup.instana.io/agent \
#     && chmod 700 ./setup_agent.sh \
#     && ./setup_agent.sh -a P79b0Ph0T9aCWi6-rjDXDw -t dynamic -l us -s
# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "npm", "start" ]  
