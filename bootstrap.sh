#!/usr/bin/env bash

set -eox pipefail

docker network create --driver bridge dpline || true

# chmod +x /vagrant/sub-services/rabbitmq/deploy.sh && \
#   /vagrant/sub-services/rabbitmq/deploy.sh
chmod +x /vagrant/sub-services/elk/deploy.sh && \
  /vagrant/sub-services/elk/deploy.sh
# chmod +x /vagrant/sub-services/jenkins/deploy.sh && \
#   /vagrant/sub-services/jenkins/deploy.sh
# chmod +x /vagrant/sub-services/prometheus/deploy.sh && \
#   /vagrant/sub-services/prometheus/deploy.sh
# chmod +x /vagrant/sub-services/consul/deploy.sh && \
#   /vagrant/sub-services/consul/deploy.sh
