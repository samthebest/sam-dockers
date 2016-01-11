# TODOs:
# Tidy a bit, organize into blocks (functions, if Docker supports functions)
# the wgets are slow first time they are ran, need to put them in /tmp/ or something outside of this docker file

# unpacking .ivy2 in image creation is slow. Use VOLUMNS for source and ivy2. Also means we won't need to rebuild the
# image in order to rerun unit tests

# Setup ubuntu

FROM ubuntu:latest
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# we have to duplicate the version numbers because docker sucks and doesn't seem to be aware of the variables
# if we use RUN source utils.sh

ENV ZOOKEEPER_VERSION 3.3.6
ENV HBASE_VERSION 0.98.15
ENV KAFKA_VERSION 0.8.2.2

RUN echo "hbase version: $HBASE_VERSION"
RUN echo "kafka version: $KAFKA_VERSION"
RUN echo "zookeeper version: $ZOOKEEPER_VERSION"

RUN apt-get update && apt-get -y install htop mc sysstat netcat net-tools lsof telnet traceroute wget busybox nano less ed vim man sudo zip unzip curl ssh openssl logrotate libc-bin locales

RUN apt-get install -y software-properties-common

RUN service ssh start

# Install java

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN apt-get install -y oracle-java8-installer

RUN export JAVA_HOME=/usr/lib/jvm/java-8-oracle/

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/

# put the source code of the project into the docker

VOLUME /root/foo

ADD run-integrations-test.sh /root/run-integrations-test.sh

# This doesn't actually seem to work, it's as though it just goes and downloads anyway

VOLUME /root/.ivy2

# Install HBase

RUN mkdir /hbase-setup
WORKDIR /hbase-setup

ADD hbase-${HBASE_VERSION}-hadoop2-bin.tar.gz /opt/
RUN ln -s /opt/hbase-${HBASE_VERSION}-hadoop2 /opt/hbase

RUN /opt/hbase/bin/hbase-config.sh

ADD hbase-site.xml /opt/hbase/conf/hbase-site.xml

WORKDIR /opt/hbase/bin

ENV PATH=$PATH:/opt/hbase/bin

# Install zookeeper

# According to https://hub.docker.com/r/spotify/kafka/~/dockerfile/ we don't need to do zookeeper manually

ADD zookeeper-${ZOOKEEPER_VERSION}.tar.gz /root/
ADD zoo.cfg /root/zookeeper-${ZOOKEEPER_VERSION}/conf/zoo.cfg

# Install kafka

ADD kafka_2.11-${KAFKA_VERSION}.tgz /root/
ADD server.properties /root/config/server.properties

ADD start-kafka.sh /usr/bin/start-kafka.sh

# Install sbt

RUN echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-get update
RUN apt-get -y --force-yes install sbt

# We run sbt update once just to pull down sbt

RUN cd /root/vouchers/ && sbt update

# Start all

ADD ./utils.sh /root/utils.sh

ADD ./start-all.sh /root/start-all.sh

CMD /root/start-all.sh
