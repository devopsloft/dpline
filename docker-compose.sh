#!/usr/bin/env bash

set -eox pipefail

set -o allexport
[[ -f /vagrant/.env ]] && source /vagrant/.env
set +o allexport

echo $GITHUB_TOKEN | docker login docker.pkg.github.com --username $GITHUB_USERNAME --password-stdin
docker-compose -f /vagrant/docker-compose.yml pull --quiet
docker-compose -f /vagrant/docker-compose.yml up -d
/vagrant/sub-services/elk/deploy.sh
