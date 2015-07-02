FROM ubuntu:14.04
MAINTAINER Andrey Ivanov stayhardordie@gmail.com
RUN apt-get install -y software-properties-common
# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y zip && \	
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

WORKDIR /home
RUN wget http://download.eclipse.org/jetty/stable-9/dist/jetty-distribution-9.3.0.v20150612.tar.gz
RUN tar -xvf ./jetty-distribution-9.3.0.v20150612.tar.gz
RUN rm -rf ./jetty-distribution-9.3.0.v20150612.tar.gz
RUN wget https://github.com/stalehard/docker-jetty-graphhopper/archive/master.zip

RUN unzip ./master.zip
RUN rm -rf ./master.zip
RUN mv ./docker-jetty-graphhopper-master/config.properties ./jetty-distribution-9.3.0.v20150612/config.properties
RUN mv ./docker-jetty-graphhopper-master/root.war ./jetty-distribution-9.3.0.v20150612/webapps/root.war
RUN rm -rf ./docker-jetty-graphhopper-master
WORKDIR /home/jetty-distribution-9.3.0.v20150612
EXPOSE 8080


