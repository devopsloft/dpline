FROM logstash:6.6.1

WORKDIR /opt/logstash

RUN bin/logstash-plugin install logstash-input-rabbitmq
ADD pipeline/ /usr/share/logstash/pipeline/
