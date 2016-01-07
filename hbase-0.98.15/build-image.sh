#!/bin/bash

version=0.98.15

docker build --rm=true -t hbase-${version} .