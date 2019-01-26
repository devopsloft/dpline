#!/usr/bin/env bash

if ! [ -x "$(command -v VBoxManage)" ]; then
    echo 'Error: vagrant is not installed.' >&2
    exit 1
fi

if ! [ -x "$(command -v vagrant)" ]; then
  echo 'Error: vagrant is not installed.' >&2
  exit 1
fi

vagrant box update
vagrant up
