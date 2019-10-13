#!/usr/bin/env bash

set -eox pipefail

set -o allexport
[[ -f /vagrant/.env ]] && source /vagrant/.env
set +o allexport

echo $GITHUB_TOKEN | docker login docker.pkg.github.com --username $GITHUB_USERNAME --password-stdin

cd /vagrant
docker-compose pull
docker-compose -f create-certs.yml run --rm create_certs
docker-compose up -d
