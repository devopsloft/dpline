#!/usr/bin/env bash

set -eo pipefail

# Install required roles
ansible-galaxy install -r requirements.yml

# Setup Host
ansible-playbook setup/prepare_host.yml

# Deploy dpline
jenkins/deploy.sh
rabbitmq/deploy.sh
prometheus/deploy.sh
