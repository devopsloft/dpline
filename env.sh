#!/usr/bin/env bash

set -e

ACTION=$1
ENV=$2

if ! [ -x "$(command -v VBoxManage)" ]; then
  echo 'Error: VirtualBox is not installed.'
  exit 1
fi

if ! [ -x "$(command -v vagrant)" ]; then
  echo 'Error: vagrant is not installed.'
  exit 1
fi

# if [[ "$OSTYPE" == "darwin"* ]]; then
#   if [ -z "$(spctl --assess --verbose /Applications/Xcode.app > /dev/null 2>&1)" ]; then
#     echo 'Error: Xcode is not installed'
#     exit 1
#   fi
# fi

if [ "$ACTION" == "up" ]; then

  if ! [ -x "$(command -v ansible)" ]; then
    virtualenv -p python3 venv
    source venv/bin/activate
    pip install ansible
  fi

  vagrant box update
  vagrant up $ENV

elif [ "$ACTION" == "destroy" ]; then

  vagrant destroy -f $ENV

fi
