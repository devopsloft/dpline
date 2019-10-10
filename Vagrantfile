Vagrant.require_version ">= 2.2.5"


Vagrant.configure("2") do |config|

  config.env.enable

  config.vm.define "dev" do |dev|

    dev.vm.box = "fedora/30-cloud-base"

    dev.vm.provision :shell, path: "bootstrap.sh"

    dev.vm.provision :docker_compose,
      compose_version: "1.24.1"
    dev.vm.provision :shell, path: "docker-compose.sh"

    dev.vm.network "forwarded_port", guest: 5000, host: 5000
    dev.vm.network "forwarded_port", guest: 5044, host: 5044
    dev.vm.network "forwarded_port", guest: 9600, host: 9600
    dev.vm.network "forwarded_port", guest: 9300, host: 9300
    dev.vm.network "forwarded_port", guest: 5672, host: 5672
    dev.vm.network "forwarded_port", guest: 15672, host: 15672
    dev.vm.network "forwarded_port", guest: 5601, host: 5601
    dev.vm.network "forwarded_port", guest: 9200, host: 9200
    dev.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.cpus = 2
    end

  end

end
