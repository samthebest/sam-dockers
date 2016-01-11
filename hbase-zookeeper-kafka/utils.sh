#!/bin/bash

ZOOKEEPER_VERSION=3.3.6
HBASE_VERSION=0.98.15
KAFKA_VERSION=0.8.2.2

function update_src_for_tests {
	# TODO Might be able to avoid this copy by doing something clever with symlinks
	echo "Ensuring latest code is mounted"
	sudo rm -r ./foo || echo "vouchers already clean"
	cp -r ../.. /tmp/foo
	rm -r /tmp/foo/docker
	rm -r /tmp/foo/target
	rm -r /tmp/foo/*/target
	mv /tmp/foo ./
}
