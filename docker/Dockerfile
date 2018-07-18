#FROM resin/rpi-raspbian:latest
FROM nodered/node-red-docker
 USER root
 RUN apt-get update
 RUN apt-get install python-pip libpq-dev build-essential python-dev git libxml2 libxml2-dev libxslt1-dev libtiff5-dev libjpeg62-turbo-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk -y
 RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
 RUN apt-get install -y nodejs build-essential -y
 RUN apt-get update && apt-get upgrade -y
 # build Node-red modules
 # [TIP] minimize image rebuilds needs by isolating dependencies from declarative aspects
 WORKDIR /usr/src/node-red/node_modules/node-red/
 COPY package.json /usr/src/node-red/node_modules/node-red/package.json
 RUN npm install node-red-node-msgpack -save
 RUN npm install node-red-node-base64 -save
 RUN npm install node-red-node-suncalc -save
 RUN npm install node-red-node-random -save
 RUN npm install node-red-contrib-apiai -save
 RUN npm install node-red-contrib-asterisk -save
 RUN npm install node-red-contrib-dns -save
 RUN npm install node-red-contrib-excel -save
 RUN npm install node-red-contrib-ftp -save
 RUN npm install node-red-contrib-googlechart -save
 RUN npm install node-red-contrib-json -save
 RUN npm install node-red-contrib-meraki-cmx -save
 RUN npm install node-red-contrib-mongodb2 -save
 RUN npm install node-red-contrib-slackbot -save
 RUN npm install node-red-contrib-spark -save
 RUN npm install node-red-node-google -save
 RUN npm install node-red-node-mongodb -save
 RUN npm install node-red-node-swagger -save
 RUN npm install node-red-node-twilio -save
 RUN npm install node-red-contrib-ale-rainbow -save
 RUN npm install node-red-node-email -save
 RUN npm install node-red-contrib-chatbot -save
 RUN npm install node-red-contrib-web-worldmap -save

 # RUN npm install
 COPY flows.json /root/.node-red/flows.json
 COPY Logo-DimensionData.png /usr/src/node-red/Logo-DimensionData.png
 COPY settings.js /root/.node-red/settings.js

 # COPY flows_rpi.json /root/.node-red/flows_rpi.json
 # WORKDIR $HOME/.node-red
 # COPY package.json $HOME/.node-red/package.json
 # COPY flows.json $HOME/.node-red/flows.json
 # COPY Logo-DimensionData.png $HOME/.node-red/Logo-DimensionData.png
 # COPY settings.js $HOME/.node-red/node_modules/node-red/settings.js
 # RUN npm install
 # COPY flows.json $HOME/.node-red/flows_rpi.json
 CMD [ "npm", "start" ]
