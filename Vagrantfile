Vagrant.configure("2") do |config|

  config.vm.define "dev" do |dev|

    dev.vm.box = "fedora/29-cloud-base"
    dev.vm.provision "shell",path: "bootstrap.sh"
    dev.vm.network "forwarded_port", guest: 8080, host: 8080
    dev.vm.network "forwarded_port", guest: 9090, host: 9090
    dev.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
    end

  end

end
