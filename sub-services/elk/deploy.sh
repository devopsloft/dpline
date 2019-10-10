#!/usr/bin/env bash

set -euox pipefail

/vagrant/sub-services/elk/elasticsearch/deploy.sh
/vagrant/sub-services/elk/kibana/deploy.sh
