#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

chmod +x elasticsearch/deploy.sh && \
  elasticsearch/deploy.sh

# chmod +x logstash/deploy.sh && \
#   logstash/deploy.sh

chmod +x kibana/deploy.sh && \
  kibana/deploy.sh
