#!/usr/bin/env bash

set -eox pipefail

# Delete Dpline
ansible-playbook jenkins/delete.yml
ansible-playbook prometheus/delete.yml
ansible-playbook rabbitmq/delete.yml
