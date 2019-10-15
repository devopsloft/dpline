#!/usr/bin/env bash

set -eox pipefail

pip3 install -r /vagrant/requirements.txt
dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
dnf makecache
until dnf -y install docker-ce; do
  echo "Try again"
done
systemctl start docker.service
systemctl enable docker.service
