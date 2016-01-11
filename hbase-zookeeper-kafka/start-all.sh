#!/bin/bash

source /root/utils.sh

/opt/hbase/bin/start-hbase.sh
/root/zookeeper-${ZOOKEEPER_VERSION}/bin/zkServer.sh start
/root/kafka_2.11-${KAFKA_VERSION}/bin/kafka-server-start.sh /root/config/server.properties

/root/run-integrations-test.sh
