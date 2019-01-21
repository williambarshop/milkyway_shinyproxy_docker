FROM openjdk:8-jre

MAINTAINER William Barshop "wbarshop@ucla.edu"
#This will be a very simple image, but it MUST be run privileged to work as Docker-in-Docker.

# system libraries, java, etc
RUN apt-get update -qq && apt-get install -qqy \
    curl
RUN curl -sSL https://get.docker.com/ | sh

RUN mkdir -p /opt/shinyproxy/
RUN wget https://www.shinyproxy.io/downloads/shinyproxy-2.1.0.jar -O /opt/shinyproxy/shinyproxy.jar
COPY application.yml /opt/shinyproxy/application.yml
WORKDIR /opt/shinyproxy/

#RUN mkdir /shinyproxy/
#WORKDIR /shinyproxy/

#COPY application.yml application.yml
#RUN wget https://www.shinyproxy.io/downloads/shinyproxy-2.1.0.jar
#RUN echo "ExecStart=/usr/bin/docker daemon -H fd:// -D -H tcp://0.0.0.0:2375" >> /lib/systemd/system/docker.service

#EXPOSE 8080
#EXPOSE 2375

CMD ["java", "-jar","/opt/shinyproxy/shinyproxy.jar"]

