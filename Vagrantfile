# -*- mode: ruby -*-
# vi: set ft=ruby :
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

$my_install = <<SCRIPT
sudo apt install build-essential git -y
sudo apt install postgresql postgresql-server-dev-9.3 python3-dev libxml2-dev libxslt-dev postgresql-server-dev-9.3 -y

SCRIPT


$my_install_ubu_16 = <<SCRIPT
sudo apt update
sudo apt install build-essential git -y
sudo apt install cmake -y
sudo apt install -y lua5.1-dev libjson-c-dev iptables-dev

#cmake  -DDISABLE_STATIC_EXTENSIONS=yes  .

#wenn keine filter modules geladen sind
#z.b. iptable_filter oder iptable_filter,iptable_nat werden keine
#entsrpechenden Regeln erzeugt

#netifd
sudo apt install libnl-route-3-dev libnl-3-200 libnl-3-dev libnfnetlink-dev -y
cmake -Dnl_include_dir=/usr/include/libnl3/ .



SCRIPT

$my_install_c73 = <<SCRIPT

sudo yum install perl -y
sudo yum install epel-release -y
sudo yum install vim-enhanced -y
sudo yum install -y gcc rpm-devel

#sudo yum install -y cmake lua-devel libstdc++-devel json-devel json-c-devel iptables-devel

#libubox
#/etc/ld.so.conf.d/local.conf (/usr/local/lib)

#ubus
#uci
#firewall (cmake  -DDISABLE_STATIC_EXTENSIONS=yes  .)

#sudo yum install libnl3-devel.x86_64 -y

#netifd
# 24 IF (DEFINED nl_include_dir)
# 25   include_directories(${nl_include_dir})
# 26 ENDIF(


SCRIPT


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.define :ubu1 do |ubu1|
        ubu1.vm.box = "ubuntu/trusty64"
        ubu1.vm.hostname = 'ubu1-14'
        ubu1.vm.network  :private_network, :ip => "192.168.192.61",
        :libvirt__network_name => "default"  # leave it

        ubu1.vm.provider :libvirt do |libvirt|
            libvirt.storage_pool_name = "vagrant"
            #libvirt.storage :file, :size =>'10G', :type => 'qcow2'
            #libvirt.storage :file, :size =>'20G', :type => 'qcow2'
        end
        ubu1.vm.provider :libvirt do |domain|
            domain.cpus = 2
            domain.cpu_mode = 'host-passthrough'
            domain.memory = 2048
            domain.nested = false
            domain.volume_cache = 'none'
        end
        ubu1.vm.synced_folder "./files", "/home/vagrant/files", disabled: false, create: true, owner: "vagrant", group: "vagrant"
        ubu1.vm.provision "shell", inline: $my_install, privileged: false
    end

    config.vm.define :ubu2 do |ubu2|
        ubu2.vm.box = "xenial/libvirt"
        ubu2.vm.box_url = "http://nd-build-01.linux-appliance.net/vagrant/boxes/xenial_libvirt_0.1.0.box"
        ubu2.vm.hostname = 'ubu2-16'
        ubu2.vm.network  :private_network, :ip => "192.168.192.61",
        :libvirt__network_name => "default"  # leave it
        ubu2.vm.provider :libvirt do |libvirt|
            libvirt.storage_pool_name = "vagrant"
            #libvirt.storage :file, :size =>'10G', :type => 'qcow2'
            #libvirt.storage :file, :size =>'20G', :type => 'qcow2'
        end
        ubu2.vm.provider :libvirt do |domain|
            domain.cpus = 2
            domain.cpu_mode = 'host-passthrough'
            domain.memory = 2048
            domain.nested = false
            domain.volume_cache = 'none'
        end
        ubu2.vm.synced_folder "./files", "/home/vagrant/files", disabled: false, create: true, owner: "vagrant", group: "vagrant"
        ubu2.vm.provision "shell", inline: $my_install_ubu_16, privileged: false
    end

    config.vm.define :c73 do |c73|
        c73.vm.box = "centos/7"
        c73.vm.hostname = 'c73-01'
        c73.vm.network  :private_network, :ip => "192.168.192.63",
        :libvirt__network_name => "default"  # leave it
        c73.vm.provider :libvirt do |libvirt|
            libvirt.storage_pool_name = "vagrant"
            #libvirt.storage :file, :size =>'10G', :type => 'qcow2'
            #libvirt.storage :file, :size =>'20G', :type => 'qcow2'
        end
        c73.vm.provider :libvirt do |domain|
            domain.cpus = 2
            domain.cpu_mode = 'host-passthrough'
            domain.memory = 2048
            domain.nested = false
            domain.volume_cache = 'none'
        end
        c73.vm.synced_folder "./files", "/home/vagrant/files", disabled: false, create: true, owner: "vagrant", group: "vagrant"
        c73.vm.provision "shell", inline: $my_install_c73, privileged: false
    end
end


