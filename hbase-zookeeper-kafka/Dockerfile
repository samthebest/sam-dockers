FROM ubuntu:latest
RUN apt-get update && apt-get -y install htop mc sysstat netcat net-tools lsof telnet traceroute wget busybox nano less ed vim man sudo zip unzip curl ssh openssl logrotate libc-bin locales

RUN apt-get install -y software-properties-common

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN apt-get install -y oracle-java8-installer

RUN export JAVA_HOME=/usr/lib/jvm/java-8-oracle/
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/

RUN mkdir /hbase-setup
WORKDIR /hbase-setup

ADD ./install-hbase.sh /hbase-setup/
RUN ./install-hbase.sh

RUN /opt/hbase/bin/hbase-config.sh

ADD hbase-site.xml /opt/hbase/conf/hbase-site.xml
ADD start-pseudo-distributed.sh /opt/hbase/bin/start-pseudo-distributed.sh

# zookeeper
EXPOSE 2181
# HBase Master API port
EXPOSE 60000
# HBase Master Web UI
EXPOSE 60010
# Regionserver API port
EXPOSE 60020
# HBase Regionserver web UI
EXPOSE 60030

WORKDIR /opt/hbase/bin

ENV PATH=$PATH:/opt/hbase/bin

# hbase is installed

CMD /opt/hbase/bin/start-pseudo-distributed.sh

RUN service ssh start
ENV BASE_DIR /opt

ENV PRODUCT_HOME $BASE_DIR/product

# Install zookeeper

ENV ZOOKEEPER_VERSION 3.3.6

RUN wget -P $PRODUCT_HOME http://apache.mesi.com.ar/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz

RUN tar zxf $PRODUCT_HOME/zookeeper-*.gz -C $PRODUCT_HOME
RUN ln -s $PRODUCT_HOME/zookeeper-${ZOOKEEPER_VERSION} $ZOOKEEPER_HOME
ADD zoo.cfg $ZOOKEEPER_HOME/conf/zoo.cfg

ENV KAFKA_VERSION 0.8.2.2

RUN wget -P $PRODUCT_HOME http://mirror.cc.columbia.edu/pub/software/apache/kafka/${KAFKA_VERSION}/kafka_2.11-${KAFKA_VERSION}.tgz

RUN tar xf $PRODUCT_HOME/kafka_*.tgz -C $PRODUCT_HOME
RUN ln -s $PRODUCT_HOME/kafka_2.11-${KAFKA_VERSION} $KAFKA_HOME
ADD server.properties $KAFKA_HOME/config/server.properties

# Start HBase

CMD /opt/hbase/bin/start-pseudo-distributed.sh

# Install sbt

RUN echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
RUN sudo apt-get update
RUN apt-get -y --force-yes install sbt
