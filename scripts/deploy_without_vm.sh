#!/usr/bin/env bash

set -eox pipefail

# Setup Host
ansible-playbook setup/prepare_host.yml

# Deploy dpline
jenkins/deploy.sh
rabbitmq/deploy.sh
prometheus/deploy.sh
