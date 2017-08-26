FROM nodered/node-red-docker
 USER root
 RUN apt-get update
 RUN apt-get install python-pip -y
 RUN apt-get install libpq-dev build-essential python-dev -y
 RUN apt-get install git -y
 RUN apt-get install libxml2 libxml2-dev libxslt1-dev -y
 RUN apt-get install libtiff5-dev libjpeg62-turbo-dev zlib1g-dev libfreetype6-dev liblcms2-dev  -y
 RUN apt-get install libwebp-dev tcl8.6-dev tk8.6-dev python-tk -y
 RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
 RUN apt-get install -y nodejs build-essential -y
 RUN apt-get update && apt-get upgrade -y
 # Install Mosquitto
 RUN wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key
 RUN apt-key add mosquitto-repo.gpg.key
 RUN wget http://repo.mosquitto.org/debian/mosquitto-wheezy.list
 RUN apt-get update -y
 RUN apt-get install mosquitto -y
 WORKDIR /etc/apt/sources.list.d/
 COPY mosquitto.conf /etc/apt/sources.list.d/mosquitto.conf
 RUN /etc/init.d/mosquitto start
 # build Node-red modules
 # [TIP] minimize image rebuilds needs by isolating dependencies from declarative aspects
 WORKDIR $HOME/.node-red
 COPY package.json $HOME/.node-red/package.json
 RUN npm install

