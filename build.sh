#!/usr/bin/env bash

pushd . || exit
cd sub-services/rabbitmq || exit

docker build -t dpline/rabbitmq -f Dockerfile .
echo $GITHUB_TOKEN | docker login docker.pkg.github.com --username $GITHUB_USERNAME --password-stdin
docker tag dpline/rabbitmq:latest docker.pkg.github.com/lioramilbaum/dpline/rabbitmq:latest
docker push docker.pkg.github.com/lioramilbaum/dpline/rabbitmq

popd || exit
pushd . || exit
cd sub-services/elk/logstash || exit

docker build -t dpline/logstash -f Dockerfile .
echo $GITHUB_TOKEN | docker login docker.pkg.github.com --username $GITHUB_USERNAME --password-stdin
docker tag dpline/logstash:latest docker.pkg.github.com/lioramilbaum/dpline/logstash:latest
docker push docker.pkg.github.com/lioramilbaum/dpline/logstash

popd || exit
pushd . || exit
cd sub-services/elk/kibana || exit

docker build -t dpline/kibana -f Dockerfile .
echo $GITHUB_TOKEN | docker login docker.pkg.github.com --username $GITHUB_USERNAME --password-stdin
docker tag dpline/kibana:latest docker.pkg.github.com/lioramilbaum/dpline/kibana:latest
docker push docker.pkg.github.com/lioramilbaum/dpline/kibana

popd || exit
pushd . || exit
cd sub-services/elk/elasticsearch || exit

docker build -t dpline/elasticsearch -f Dockerfile .
echo $GITHUB_TOKEN | docker login docker.pkg.github.com --username $GITHUB_USERNAME --password-stdin
docker tag dpline/elasticsearch:latest docker.pkg.github.com/lioramilbaum/dpline/elasticsearch:latest
docker push docker.pkg.github.com/lioramilbaum/dpline/elasticsearch

popd || exit
pushd . || exit
cd sub-services/engine || exit

docker build -t dpline/engine -f Dockerfile .
echo $GITHUB_TOKEN | docker login docker.pkg.github.com --username $GITHUB_USERNAME --password-stdin
docker tag dpline/engine:latest docker.pkg.github.com/lioramilbaum/dpline/engine:latest
docker push docker.pkg.github.com/lioramilbaum/dpline/engine
