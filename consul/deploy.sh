#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

[ ! "$(docker ps -a | grep consul)" ] &&
docker run \
  --rm \
  -d \
  -p 8500:8500 \
  --network=dpline \
  --name consul \
  consul:1.4.2 agent -dev -ui -client=0.0.0.0 -bind=0.0.0.0

  while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://localhost:8500/ui/dc1/kv)" != "200" ]]; do
    sleep 5
  done

  curl -X PUT --data 'dpline' http://localhost:8500/v1/kv/application
