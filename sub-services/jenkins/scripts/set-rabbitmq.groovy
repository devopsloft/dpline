#!groovy
import jenkins.*
import jenkins.model.*
import hudson.*
import hudson.model.*
import fr.frogdevelopment.jenkins.plugins.mq.*;

RabbitMqBuilder.RabbitConfig rabbitConfig =
  new RabbitMqBuilder.RabbitConfig("rabbit","some-rabbit",5672,"dpline","dpline",false)

List<RabbitMqBuilder.RabbitConfig> rabbitConfigs = new List<RabbitMqBuilder.RabbitConfig>[1]

rabbitConfigs[0] = rabbitConfig

RabbitMqBuilder.Configs configs = new RabbitMqBuilder.Configs(rabbitConfigs)

def rabbitMqDescriptor = Jenkins.instance.getExtensionList(RabbitMqBuilder.RabbitMqDescriptor.class)[0];
rabbitMqDescriptor.setConfigs(configs);
Jenkins.getInstance().save();
