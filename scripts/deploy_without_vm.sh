#!/usr/bin/env bash

set -eo pipefail

# Install required roles
ansible-galaxy install -r requirements.yml

# Setup Host
ansible-playbook setup/prepare_host.yml

# Deploy dpline
sub-services/jenkins/deploy.sh
sub-services/rabbitmq/deploy.sh
sub-services/prometheus/deploy.sh
