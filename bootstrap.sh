#!/usr/bin/env bash

set -eox pipefail

echo "Getting updates..."
apt-get update

echo "Installing Python3..."
apt-get install -y python3

echo "Installing pip..."
apt-get install -y python3-pip

echo "Upgrading pip..."
pip3 install --upgrade pip
pip install ansible

# Setup Host
ansible-playbook /vagrant/setup/prepare_host.yml

# Deploy dpline
jenkins/deploy.sh
rabbitmq/deploy.sh
prometheus/deploy.sh
