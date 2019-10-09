FROM rabbitmq:3.8.0-management
MAINTAINER Liora Milbaum <liora@lmb.co.il>

# Define environment variables.
ENV RABBITMQ_USER dpline
ENV RABBITMQ_PASSWORD dpline

ADD rabbitmq.config /etc/rabbitmq/
ADD definitions.json /etc/rabbitmq/

ADD init.sh /init.sh
EXPOSE 5672 15672

# Define default command
CMD ["/init.sh"]
