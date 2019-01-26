Vagrant.configure("2") do |config|
  config.vm.box = "fedora/29-cloud-base"
  config.vm.provision "shell",path: "bootstrap.sh"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 9090, host: 9090
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end
end
