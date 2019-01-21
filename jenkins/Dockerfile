FROM jenkinsci/blueocean
MAINTAINER Liora Milbaum <liora@lmb.co.il>

ENV JENKINS_ADMIN_USER="jenkins" JENKINS_ADMIN_PASS="jenkins"
COPY ./scripts/basic-security.groovy ${JENKINS_HOME}/init.groovy.d/basic-security.groovy
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
