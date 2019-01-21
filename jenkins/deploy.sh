#!/usr/bin/env bash

set -euox pipefail

docker build -t dpline/jenkins -f jenkins/Dockerfile .

[ ! "$(docker ps -a | grep jenkins)" ] &&
docker run \
  -u root \
  --rm \
  -d \
  -p 8080:8080 \
  -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --name jenkins \
  dpline/jenkins
