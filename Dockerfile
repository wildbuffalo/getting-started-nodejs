FROM node:10-alpine
# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./


RUN npm install
RUN npm install appdynamics@4.4.3
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .
EXPOSE 8080
CMD [ "npm", "start" ]
