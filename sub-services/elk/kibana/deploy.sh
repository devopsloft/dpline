#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

docker build -t dpline/kibana -f Dockerfile .

[ ! "$(docker ps -a | grep kibana)" ] &&
docker run \
  --rm \
  -d \
  -p 5601:5601 \
  --network=dpline \
  --name kibana \
  dpline/kibana

while [[ "$(curl -s -o /dev/null -w '%{http_code}' localhost:5601)" != "200" ]]; do
  sleep 5
done

./deploy.py
