#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

set -o allexport
[[ -f /vagrant/.env.local ]] && source /vagrant/.env.local
set +o allexport

echo $GITHUB_TOKEN | docker login docker.pkg.github.com --username $GITHUB_USERNAME --password-stdin

[ ! "$(docker ps -a | grep kibana)" ] &&
docker run \
  --rm \
  -d \
  -p 5601:5601 \
  --network=dpline \
  --name kibana \
  docker.pkg.github.com/lioramilbaum/dpline/kibana:latest

while [[ "$(curl -s -o /dev/null -w '%{http_code}' http://localhost:5601/app/kibana)" != "200" ]]; do
  sleep 5
done

./deploy.py
