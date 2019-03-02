#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

docker build -t dpline/rabbitmq -f Dockerfile .

[ ! "$(docker ps -a | grep some-rabbit)" ] &&
docker run \
  --rm \
  -d \
  -p 5672:5672 \
  -p 15672:15672 \
  --network=dpline \
  --hostname my-rabbit \
  --name some-rabbit \
  dpline/rabbitmq
