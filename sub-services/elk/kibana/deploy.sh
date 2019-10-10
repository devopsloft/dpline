#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

while [[ "$(curl -s -o /dev/null -w '%{http_code}' http://localhost:5601/app/kibana)" != "200" ]]; do
  sleep 5
done

./deploy.py
