#!/usr/bin/env bash

set -eox pipefail

echo "Installing Python3..."
dnf install -y python3

echo "Installing pip..."
dnf install -y python3-pip

echo "Upgrading pip..."
pip3 install --upgrade pip
pip install ansible

# Setup Host
ansible-playbook /vagrant/setup/prepare_host.yml

# Deploy dpline
jenkins/deploy.sh
rabbitmq/deploy.sh
prometheus/deploy.sh
