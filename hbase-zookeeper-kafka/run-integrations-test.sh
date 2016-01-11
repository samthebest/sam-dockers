#!/bin/bash

set -e

cd /root/vouchers

echo "DEBUG: Java version:"

java -version

sbt "it:test-only fred.FooSpecs"
