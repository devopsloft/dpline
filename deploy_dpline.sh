#!/usr/bin/env bash

set -eox pipefail

# Prepare virtual environment
virtualenv --system-site-packages /tmp/dpline_venv && source /tmp/dpline_venv/bin/activate
pip install ansible

# Setup Host
ansible-playbook setup/prepare_host.yml

# Deploy dpline
jenkins/deploy.sh
rabbitmq/deploy.sh
prometheus/deploy.sh
