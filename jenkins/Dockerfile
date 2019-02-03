FROM jenkins/jenkins:latest
MAINTAINER Liora Milbaum <liora@lmb.co.il>

ENV JENKINS_ADMIN_USER="jenkins" JENKINS_ADMIN_PASS="jenkins"

COPY scripts/basic-security.groovy ${JENKINS_HOME}/init.groovy.d/basic-security.groovy
COPY scripts/set-rabbitmq.groovy ${JENKINS_HOME}/init.groovy.d/set-rabbitmqy.groovy

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

RUN /usr/local/bin/install-plugins.sh jdk-tool:1.2 \
                                      rabbitmq-publisher:1.0
