#!/bin/bash

source utils.sh

update_src_for_tests

docker run -v `pwd`/foo:/root/foo -v ~/.ivy2:/root/.ivy2 test-docker
