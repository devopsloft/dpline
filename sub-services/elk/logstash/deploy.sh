#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

docker build -t dpline/logstash -f Dockerfile .

[ ! "$(docker ps -a | grep logstash)" ] &&
docker run \
  --rm \
  -d \
  -p 5000:5000 \
  -p 5044:5044 \
  -p 9600:9600 \
  --network=dpline \
  --name logstash \
  dpline/logstash
