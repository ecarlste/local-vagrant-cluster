Vagrant.configure("2") do |config|
  vm_box = "ubuntu/jammy64"
  vm_box_version = "20241002.0.0"
  
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
