#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

set -o allexport
[[ -f /vagrant/.env.local ]] && source /vagrant/.env.local
set +o allexport

echo $GITHUB_TOKEN | docker login docker.pkg.github.com --username $GITHUB_USERNAME --password-stdin

[ ! "$(docker ps -a | grep logstash)" ] &&
docker run \
  --rm \
  -d \
  -p 5000:5000 \
  -p 5044:5044 \
  -p 9600:9600 \
  --network=dpline \
  --name logstash \
  docker.pkg.github.com/lioramilbaum/dpline/logstash:latest
