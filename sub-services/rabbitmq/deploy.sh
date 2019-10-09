#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

set -o allexport
[[ -f /vagrant/.env.local ]] && source /vagrant/.env.local
set +o allexport

echo $GITHUB_TOKEN | docker login docker.pkg.github.com --username $GITHUB_USERNAME --password-stdin

[ ! "$(docker ps -a | grep rabbitmq)" ] &&
docker run \
  --rm \
  -d \
  -p 5672:5672 \
  -p 15672:15672 \
  --network=dpline \
  --name rabbitmq \
  docker.pkg.github.com/lioramilbaum/dpline/rabbitmq:latest
