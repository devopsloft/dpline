#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

docker build -t dpline/engine -f Dockerfile .

[ ! "$(docker ps -a | grep engine)" ] &&
docker run \
  --rm \
  -d \
  --network=dpline \
  --name engine \
  dpline/engine
