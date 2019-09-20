#!/usr/bin/env bash

set -e

ACTION=$1
ENV=$2

echo "Verifying VirtualBox installed"
if ! [ -x "$(command -v VBoxManage)" ]; then
  echo 'Error: VirtualBox is not installed.'
  exit 1
fi

echo "Verifying VirtualBox supported version"
if [ $(virtualbox --help | head -n 1 | awk '{print $NF}') != "v6.0.12" ]; then
  echo 'Error: Unsupported VirtualBox version'
  exit 1
fi

echo "Verifying vagrant installed"
if ! [ -x "$(command -v vagrant)" ]; then
  echo 'Error: vagrant is not installed.'
  exit 1
fi

if [ "$ACTION" == "up" ]; then

  if ! [ -x "$(command -v ansible)" ]; then
    virtualenv -p python3 venv
    source venv/bin/activate
    pip install ansible python-jenkins
  fi

  vagrant box update
  vagrant up $ENV

  while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:8080)" != "200" ]]; do
    sleep 5
  done
  ./test/e2e.py

elif [ "$ACTION" == "destroy" ]; then

  vagrant destroy -f $ENV

fi
