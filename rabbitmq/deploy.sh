#!/usr/bin/env bash

set -euox pipefail

[ ! "$(docker ps -a | grep some-rabbit)" ] &&
docker run \
  -d \
  --hostname my-rabbit \
  --name some-rabbit \
  rabbitmq:3.7.8
