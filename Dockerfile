# Zookeeper
#
# Version 3.4.5

FROM ubuntu:latest
MAINTAINER Javier Rey javirey@gmail.com

# Update the APT cache
RUN sed -i.bak 's/main$/main universe/' /etc/apt/sources.list
RUN apt-get update

# Install curl
RUN apt-get install -y curl

# Adding webupd8team ppa
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main\ndeb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" >>  /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv EEA14886

RUN apt-get update

# Install Java 6
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java6-installer

# Zookeeper dir
RUN mkdir -p /var/run/zookeeper
RUN echo "1" > /var/run/zookeeper/myid
RUN cat /var/run/zookeeper/myid

RUN locale-gen en_US en_US.UTF-8

# Downloading zookeeper 3.4.5
RUN curl http://mirror.sdunix.com/apache/zookeeper/zookeeper-3.4.5/zookeeper-3.4.5.tar.gz -o /home/zookeeper.tar.gz
RUN tar -xzf /home/zookeeper.tar.gz -C /home
RUN mv /home/zookeeper-3.4.5 /home/zookeeper
RUN rm /home/zookeeper.tar.gz

ADD zoo.cfg /home/zookeeper/conf/zoo.cfg

RUN chmod +x /home/zookeeper/bin/zkServer.sh

EXPOSE 2181 2888 3888

CMD echo "${ZOO_NODE_NUM}" > /var/run/zookeeper/myid && cat /var/run/zookeeper/myid && /home/zookeeper/bin/zkServer.sh start-foreground
