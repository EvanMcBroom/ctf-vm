# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.username = "vagrant"
  config.ssh.forward_agent = true

  config.vm.box = "generic/ubuntu1804"

  config.vm.provider "hyperv" do |h|
    h.vmname = "ctf"
    h.memory = "2048"
    h.enable_virtualization_extensions = true
    h.differencing_disk = true
  end

  config.vm.synced_folder '.', '/vagrant', type: 'smb', mount_options: ['vers=3.0']
end
