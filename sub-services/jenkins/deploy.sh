#!/usr/bin/env bash

set -euox pipefail

home=$( dirname "${BASH_SOURCE[0]}" )
cd $home

JENKINS_VERSION=$(python3 -c "import sys;sys.path.append('../../services/versions');import dpline_versions; dpline_versions.versions_get_current('jenkins')")
JDK_VERSION=$(python3 -c "import sys;sys.path.append('../../services/versions');import dpline_versions; dpline_versions.versions_get_current('jdk-tool')")
RP_VERSION=$(python3 -c "import sys;sys.path.append('../../services/versions');import dpline_versions; dpline_versions.versions_get_current('rabbitmq-publisher')")

docker build -t dpline/jenkins \
  --build-arg BASE_IMAGE=jenkins/jenkins:$JENKINS_VERSION \
  --build-arg JDK_TOOL_PLUGIN=jdk-tool:$JDK_VERSION \
  --build-arg RABBITMQ_PUBLISHER_PLUGIN=rabbitmq-publisher:$RP_VERSION \
  -f Dockerfile .

[ ! "$(docker ps -a | grep jenkins)" ] &&
docker run \
  -u root \
  --rm \
  -d \
  -p 8080:8080 \
  -p 50000:50000 \
  --network=dpline \
  --name jenkins \
  dpline/jenkins
