# -*- mode: ruby -*-
# vim: set ft=ruby :
# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
#:nassrv10 => {
#    :box_name => "centos/7",
#    :disks => {
#      :sata1 => {
#        :dfile => './nassrv10_sata1.vdi',
#        :size => 1000,
#        :port => 1
#      }
#    },
#    :ssh_port => 33553,
#    :net => [
#               {ip: '192.168.30.144', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "moscow-net"},
#            ]
#
#},
:pgsrv01 => {
        :box_name => "centos/7",
        :ssh_port => 33550,
        :net => [
               {ip: '192.168.30.70', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "moscow-net"},
            ]
  },
:pgsrv02 => {
        :box_name => "centos/7",
        :ssh_port => 33551,
        :net => [
               {ip: '192.168.30.71', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "moscow-net"},
            ]
  }, 
:consul => {
        :box_name => "centos/7",
        :ssh_port => 33554,
        :net => [
               {ip: '192.168.30.100', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "moscow-net"},
            ]
  },               
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|

    config.vm.define boxname do |box|

        box.vm.box = boxconfig[:box_name]
        box.vm.host_name = boxname.to_s

        box.vm.network :forwarded_port, guest: 22, host: boxconfig[:ssh_port], id: "ssh", auto_correct: true

        boxconfig[:net].each do |ipconf|
          box.vm.network "private_network", ipconf
        end
        
        if boxconfig.key?(:public)
          box.vm.network "public_network", boxconfig[:public]
        end


        box.vm.provider :virtualbox do |vb|
          vb.customize ["modifyvm", :id, "--memory", "1024"]
          vb.customize ["modifyvm", :id, "--cpuexecutioncap", "95"]
          needsController = false
          if boxconfig.key?(:disks)
            boxconfig[:disks].each do |dname, dconf|
              unless File.exist?(dconf[:dfile])
                  vb.customize ['createhd', '--filename', dconf[:dfile], '--variant', 'Fixed', '--size', dconf[:size]]
                  needsController =  true
              end
            end
            if needsController == true
              vb.customize ["storagectl", :id, "--name", "SATA", "--add", "sata" ]
              boxconfig[:disks].each do |dname, dconf|
                  vb.customize ['storageattach', :id,  '--storagectl', 'SATA', '--port', dconf[:port], '--device', 0, '--type', 'hdd', '--medium', dconf[:dfile]]
              end
            end
          end
        end

        box.vm.provision "shell", inline: <<-SHELL
            mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh
            sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
            systemctl restart sshd
            yum install -y gdisk
            sudo echo "192.168.30.144 nassrv10" >> /etc/hosts
            sudo echo "192.168.30.100 consul" >> /etc/hosts
            sudo echo "192.168.30.70 pgsrv01" >> /etc/hosts
            sudo echo "192.168.30.71 pgsrv02" >> /etc/hosts
       
          SHELL

        case boxname.to_s
        when "nassrv10"  
          box.vm.provision "shell", run: "always", inline: <<-SHELL
          sudo yum install -y lvm2
          #sudo chmod guo+x /vagrant/bin/initial_disk.sh
          #sudo /vagrant/bin/initial_disk.sh
          SHELL
        end

        if boxname.to_s == "consul"
          box.vm.provision "ansible" do |ansible|
            ansible.verbose = "v"
            ansible.playbook = "provisioning/playbook_postgres1c.yml"
            ansible.become = "true"
            ansible.limit = "all"
            ansible.inventory_path = "provisioning/hosts" 
          end
        end
    
      end

  end
  
end
