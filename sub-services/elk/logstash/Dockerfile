FROM logstash:7.3.2

WORKDIR /opt/logstash

RUN bin/logstash-plugin install logstash-input-rabbitmq
ADD pipeline/ /usr/share/logstash/pipeline/
