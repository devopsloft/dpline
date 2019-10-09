#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

set -o allexport
[[ -f /vagrant/.env.local ]] && source /vagrant/.env.local
set +o allexport

echo $GITHUB_TOKEN | docker login docker.pkg.github.com --username $GITHUB_USERNAME --password-stdin

[ ! "$(docker ps -a | grep engine)" ] &&
docker run \
  --rm \
  -d \
  --network=dpline \
  --name engine \
  docker.pkg.github.com/lioramilbaum/dpline/engine:latest
