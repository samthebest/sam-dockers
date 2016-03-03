#!/bin/bash

eval "$(docker-machine env default)"

docker build -t mysql-docker .

docker run mysql-docker
