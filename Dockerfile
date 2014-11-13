FROM dockerfile/nodejs:latest

# Install Git
RUN apt-get install -y git

# Add source
ADD ./node_modules /opt/zorium-starter/node_modules
ADD . /opt/clay-mobile

WORKDIR /opt/zorium-starter

# Install app deps
RUN npm install

CMD ["npm", "start"]
