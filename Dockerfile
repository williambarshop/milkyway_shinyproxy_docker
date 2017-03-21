FROM ubuntu:16.04

MAINTAINER William Barshop "wbarshop@ucla.edu"
#This will be a very simple image, but it MUST be run privileged to work as Docker-in-Docker.

# system libraries, java, etc
RUN apt-get update -qq && apt-get install -qqy \
    default-jre \
    default-jdk \
    wget \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables 

RUN curl -sSL https://get.docker.com/ | sh

RUN mkdir /shinyproxy/
WORKDIR /shinyproxy/

COPY application.yml application.yml
RUN wget https://www.shinyproxy.io/downloads/shinyproxy-0.8.6.jar
RUN echo "ExecStart=/usr/bin/docker daemon -H fd:// -D -H tcp://0.0.0.0:2375" >> /lib/systemd/system/docker.service

EXPOSE 8080
EXPOSE 2375

CMD ["java", "-jar","shinyproxy-0.8.6.jar"]

