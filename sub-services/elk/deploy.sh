#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

[ ! "$(docker ps -a | grep elasticsearch)" ] &&
docker run \
  -d \
  -p 9200:9200 \
  -p 9300:9300 \
  -e "discovery.type=single-node" \
  --network=dpline \
  --name elasticsearch \
  elasticsearch:6.6.1

[ ! "$(docker ps -a | grep kibana)" ] &&
docker run \
  --rm \
  -d \
  -p 5601:5601 \
  --network=dpline \
  --name kibana \
  kibana:6.6.1

while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:9200)" != "200" ]]; do
  sleep 5
done

curl -X PUT "http://localhost:9200/cnv" -H "Content-Type: application/json" \
  -d @index.json

chmod +x artifacts.sh && ./artifacts.sh

while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:5601/status)" != "200" ]]; do
  sleep 5
done

curl -X POST -H 'kbn-xsrf: true' -H 'Content-Type: application/json' \
  'http://localhost:5601/api/saved_objects/index-pattern/cnv' \
   -d @index-pattern.json

curl -X POST -H 'kbn-xsrf: true' -H 'Content-Type: application/json' \
'http://localhost:5601/api/saved_objects/search/cnv' -d @search.json

curl -X POST -H 'kbn-xsrf: true' -H 'Content-Type: application/json' \
'http://localhost:5601/api/saved_objects/dashboard/cnv' -d @dashboard.json

curl -X POST -H 'kbn-xsrf: true' -H 'Content-Type: application/json' \
  'http://localhost:5601/api/telemetry/v1/optIn' -d '{"enabled":false}'
