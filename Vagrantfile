require "yaml"
vagrant_root = File.dirname(File.expand_path(__FILE__))
vagrant_settings = YAML.load_file "#{vagrant_root}/vagrant-settings.yaml"

Vagrant.configure("2") do |config|
  vm_box = vagrant_settings["boxes"]["vm_box"]
  vm_box_version = vagrant_settings["boxes"]["vm_box_version"]

  config.vm.define "controlplane" do |controlplane|
    controlplane.vm.hostname = "controlplane"
    controlplane.vm.box = vm_box
    controlplane.vm.box_version = vm_box_version
  end

  (1..2).each do |i|
    node_name = "node%02d" % i

    config.vm.define "#{node_name}" do |node|
      node.vm.hostname = "#{node_name}"
      node.vm.box = vm_box
      node.vm.box_version = vm_box_version
    end
  end
end
