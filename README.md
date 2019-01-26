# Dpline

[![Build Status](https://travis-ci.org/bregman-arie/dpline.svg?branch=refactor)](https://travis-ci.org/bregman-arie/dpline)

Delivery Pipeline


## Prerequesites

vagrant
virtualbox

## Usage

Spawn dpline environment:

    ./dpline-env.sh

Or using Dpline CLI:

    pipenv install . && pipenv shell
    dpline deploy

To deploy directly on your environment, without a VM:

    dpline deploy --directly


## Access

A summary of how to access the different services deployed by dpline

Service | Address | User | Password
:------ |:------|:------:|:--------:
Jenkins | [http://localhost:8080](http://localhost:8080) | jenkins | jenkins |
Prometheus | [http://localhost:9090](http://localhost:9090) | None | None |
