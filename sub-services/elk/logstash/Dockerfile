FROM logstash:7.4.0

WORKDIR /opt/logstash

RUN bin/logstash-plugin install logstash-input-rabbitmq
ADD pipeline/ /usr/share/logstash/pipeline/
