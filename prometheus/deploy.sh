#!/usr/bin/env bash

set -euox pipefail

[ ! "$(docker ps -a | grep prometheus)" ] &&
docker run \
  --rm \
  -d \
  -p 9090:9090 \
  --network=dpline \
  --name prometheus \
  prom/prometheus
