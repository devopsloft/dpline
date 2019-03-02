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

docker network create --driver bridge dpline || true

# Deploy dpline

chmod +x /vagrant/sub-services/rabbitmq/deploy.sh && \
  /vagrant/sub-services/rabbitmq/deploy.sh
chmod +x /vagrant/sub-services/elk/deploy.sh && \
  /vagrant/sub-services/elk/deploy.sh
# chmod +x /vagrant/sub-services/jenkins/deploy.sh && \
#   /vagrant/sub-services/jenkins/deploy.sh
# chmod +x /vagrant/sub-services/prometheus/deploy.sh && \
#   /vagrant/sub-services/prometheus/deploy.sh
# chmod +x /vagrant/sub-services/consul/deploy.sh && \
#   /vagrant/sub-services/consul/deploy.sh
