FROM netknight/java-env:latest
MAINTAINER Nicola Ferraro <nibbio84@gmail.com>

# RUN yum install -y java-1.8.0-openjdk.x86_64
# ENV JAVA_HOME=/usr/lib/jvm/jre

# RUN yum install -y wget
# RUN yum install -y nc
# RUN yum install -y tar

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
