# dpline

[![Build Status](https://travis-ci.org/bregman-arie/dpline.svg?branch=refactor)](https://travis-ci.org/bregman-arie/dpline)

Delivery Pipeline


## Prerequesites

If you want deploy Dpline inside a VM:

    vagrant
    virtualbox

## Usage

Spawn dpline environment:

    ./env.sh <up|destroy> dev

Or using dpline CLI:

    virtualenv --system-site-packages ~/dpline_venv && source ~/dpline_venv/bin/activate
    dpline deploy


To deploy Dpline inside a VM, instead of directly on your environment, run:

    dpline deploy --vm

To remove Dpline from your host, run:

    dpline delete


## Access

A summary of how to access the different services deployed by dpline

Service | Address | User | Password
:------ |:------|:------:|:--------:
Jenkins | [http://localhost:8080](http://localhost:8080) | jenkins | jenkins |
Prometheus | [http://localhost:9090](http://localhost:9090) | None | None |
RabbitMQ Management | [http://localhost:15672](http://localhost:15672) | dpline | dpline |
Consul | [http://localhost:8500](http://localhost:8500) | None | None |
Elasticsearch | [http://localhost:9200](http://localhost:9200) | None | None |
kibana | [http://localhost:5601](http://localhost:5601) | None | None |

## How it works?

When you 'dpline deploy' Dpline will do the following:

* Install required Ansible roles listed in requirements.yml
* Prepare your host for delivery pipeline deployment with `setup/prepare_host.yml`
* Deploy services (e.g. Jenkins, Prometheus, etc.)
