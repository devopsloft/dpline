#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

while [[ "$(curl -s -o /dev/null -w '%{http_code}' http://localhost:9200)" != "200" ]]; do
  sleep 5
done

curl -X PUT "http://localhost:9200/_cluster/settings" \
  -H "Content-Type: application/json" \
  -d '{"persistent":{"xpack.monitoring.collection.enabled":true}}'

./deploy.py
