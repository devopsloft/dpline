#!/usr/bin/env bash

set -euox pipefail

[ ! "$(docker ps -a | grep prometheus)" ] &&
docker run \
  -p 9090:9090 \
  --name prometheus \
  prom/prometheus
