#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

docker build -t dpline/jenkins -f Dockerfile .

[ ! "$(docker ps -a | grep jenkins)" ] &&
docker run \
  -u root \
  --rm \
  -d \
  -p 8080:8080 \
  -p 50000:50000 \
  --name jenkins \
  dpline/jenkins
