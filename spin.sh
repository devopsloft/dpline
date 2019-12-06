#!/usr/bin/env bash

set -e

ACTION=$1
ENV=$2

set -o allexport
[[ -f .env ]] && source .env
set +o allexport

if [ "$ACTION" == "up" ]; then

  echo $GITHUB_TOKEN | docker login docker.pkg.github.com --username $GITHUB_USERNAME --password-stdin

  docker-compose build
  docker-compose push

  vagrant box update
  vagrant box prune
  vagrant destroy -f $ENV
  vagrant up $ENV
  # ./test/test.py

elif [ "$ACTION" == "destroy" ]; then

  vagrant destroy -f $ENV

fi

say "done"
