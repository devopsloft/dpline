#!/usr/bin/env bash

set -euox pipefail

[ ! "$(docker ps -a | grep rabbitmq)" ] &&
docker run \
  --rm \
  -d \
  -p 5672:5672 \
  -p 15672:15672 \
  --hostname my-rabbit \
  --name rabbitmq \
  rabbitmq:3.7.8-management
