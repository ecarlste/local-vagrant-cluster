require "yaml"
vagrant_root = File.dirname(File.expand_path(__FILE__))
vagrant_settings = YAML.load_file "#{vagrant_root}/vagrant-settings.yaml"

Vagrant.configure("2") do |config|
  vm_box = vagrant_settings["boxes"]["vm_box"]
  vm_box_version = vagrant_settings["boxes"]["vm_box_version"]

  config.vm.define "controlplane" do |controlplane|
    controlplane.vm.box = vm_box
    controlplane.vm.box_version = vm_box_version
  end

  config.vm.define "node01" do |node01|
    node01.vm.box = vm_box
    node01.vm.box_version = vm_box_version
  end

  config.vm.define "node02" do |node02|
    node02.vm.box = vm_box
    node02.vm.box_version = vm_box_version
  end
end
