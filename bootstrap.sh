#!/usr/bin/env bash

set -eox pipefail

pip3 install -r /vagrant/requirements.txt
dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
dnf makecache
dnf -y install docker-ce
systemctl start docker.service
systemctl enable docker.service
docker network create --driver bridge dpline || true

chmod +x /vagrant/sub-services/rabbitmq/deploy.sh && \
  /vagrant/sub-services/rabbitmq/deploy.sh
chmod +x /vagrant/sub-services/elk/deploy.sh && \
  /vagrant/sub-services/elk/deploy.sh
chmod +x /vagrant/sub-services/engine/deploy.sh && \
  /vagrant/sub-services/engine/deploy.sh
# chmod +x /vagrant/sub-services/jenkins/deploy.sh && \
#   /vagrant/sub-services/jenkins/deploy.sh
# chmod +x /vagrant/sub-services/prometheus/deploy.sh && \
#   /vagrant/sub-services/prometheus/deploy.sh
# chmod +x /vagrant/sub-services/consul/deploy.sh && \
#   /vagrant/sub-services/consul/deploy.sh
