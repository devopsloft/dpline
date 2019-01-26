FROM rabbitmq:3.7.8-management
MAINTAINER Liora Milbaum <liora@lmb.co.il>

# Define environment variables.
ENV RABBITMQ_USER jenkins
ENV RABBITMQ_PASSWORD jenkins

ADD init.sh /init.sh
EXPOSE 5672 15672

# Define default command
CMD ["/init.sh"]
