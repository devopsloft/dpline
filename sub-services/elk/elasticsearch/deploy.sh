#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

docker build -t dpline/elasticsearch -f Dockerfile .

[ ! "$(docker ps -a | grep elasticsearch)" ] &&
docker run \
  --rm \
  -d \
  -p 9200:9200 \
  -p 9300:9300 \
  -e "discovery.type=single-node" \
  --network=dpline \
  --name elasticsearch \
  dpline/elasticsearch

while [[ "$(curl -s -o /dev/null -w '%{http_code}' http://localhost:9200)" != "200" ]]; do
  sleep 5
done

curl -X PUT "http://localhost:9200/_cluster/settings" \
  -H "Content-Type: application/json" \
  -d '{"persistent":{"xpack.monitoring.collection.enabled":true}}'

./deploy.py
