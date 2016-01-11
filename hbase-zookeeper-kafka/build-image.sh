#!/bin/bash

set -e

source utils.sh

update_src_for_tests

test -f zookeeper-${ZOOKEEPER_VERSION}.tar.gz || wget \
http://apache.mesi.com.ar/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz

test -f hbase-${HBASE_VERSION}-hadoop2-bin.tar.gz || wget \
http://archive.apache.org/dist/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-hadoop2-bin.tar.gz

test -f kafka_2.11-${KAFKA_VERSION}.tgz || wget \
http://mirror.cc.columbia.edu/pub/software/apache/kafka/${KAFKA_VERSION}/kafka_2.11-${KAFKA_VERSION}.tgz

docker build -t test-docker .
