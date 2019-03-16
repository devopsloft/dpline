ARG BASE_IMAGE
FROM $BASE_IMAGE

MAINTAINER Liora Milbaum <liora@lmb.co.il>

ENV JENKINS_ADMIN_USER="dpline" JENKINS_ADMIN_PASS="dpline"

COPY scripts/. ${JENKINS_HOME}/init.groovy.d/

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

ARG JDK_TOOL_PLUGIN
ARG RABBITMQ_PUBLISHER_PLUGIN
RUN /usr/local/bin/install-plugins.sh $JDK_TOOL_PLUGIN $RABBITMQ_PUBLISHER_PLUGIN
