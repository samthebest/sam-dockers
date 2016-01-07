#!/bin/bash

version=0.98.15

wget http://archive.apache.org/dist/hbase/${version}/hbase-${version}-hadoop2-bin.tar.gz
tar xzf hbase-${version}-hadoop2-bin.tar.gz -C /opt/
ln -s /opt/hbase-${version}-hadoop2 /opt/hbase
rm hbase-${version}-hadoop2-bin.tar.gz
