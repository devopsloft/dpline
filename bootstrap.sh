#!/usr/bin/env bash

set -eox pipefail

echo "Installing ansible..."
n=0
until [ $n -ge 2 ]
do
  dnf install -y ansible && break
  n=$[$n+1]
  sleep 15
done

ansible-galaxy install -r /vagrant/requirements.yml

# Setup Host
ansible-playbook /vagrant/setup/prepare_host.yml

docker network create --driver bridge dpline

# Deploy dpline
/vagrant/jenkins/deploy.sh
/vagrant/rabbitmq/deploy.sh
/vagrant/prometheus/deploy.sh
