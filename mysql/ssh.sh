#!/bin/bash
eval "$(docker-machine env default)"
docker exec -i -t `docker ps -a | grep mysql-docker | head -1 | awk '{print $1}'` bash
