require "yaml"
vagrant_root = File.dirname(File.expand_path(__FILE__))
vagrant_settings = YAML.load_file "#{vagrant_root}/vagrant-settings.yaml"

# get starting IP address and split by prefix and last term
ip_section_matches = vagrant_settings["network"]["ip_start"].match(/^([0-9.]+\.)([^.]+)$/)
ip_prefix = ip_section_matches.captures[0]
ip_last_term_start = Integer(ip_section_matches.captures[1])

Vagrant.configure("2") do |config|
  vm_box = vagrant_settings["boxes"]["vm_box"]
  vm_box_version = vagrant_settings["boxes"]["vm_box_version"]

  config.vm.provision "shell",
    env: { "IP_PREFIX" => ip_prefix, "IP_LAST_TERM_START" => ip_last_term_start, "WORKER_NODE_COUNT" => 2 },
    path: "scripts/setup-etc-hosts.bash"

  config.vm.define "controlplane" do |controlplane|
    controlplane.vm.hostname = "controlplane"
    controlplane.vm.network "private_network", ip: vagrant_settings["network"]["ip_start"]

    controlplane.vm.provider "virtualbox" do |vb|
      vb.cpus = vagrant_settings["boxes"]["controlplane"]["cpus"]
      vb.memory = vagrant_settings["boxes"]["controlplane"]["memory"]
    end

    controlplane.vm.box = vm_box
    controlplane.vm.box_version = vm_box_version

    controlplane.vm.provision "shell", path: "scripts/common.bash"
    controlplane.vm.provision "shell",
      env: {
        "CONTROLPLANE_IP" => vagrant_settings["network"]["ip_start"],
        "POD_CIDR" => vagrant_settings["network"]["pod_cidr"],
      },
      path: "scripts/setup-controlplane.bash"
  end

  (1..2).each do |i|
    node_name = "node%02d" % i

    config.vm.define "#{node_name}" do |node|
      node.vm.hostname = "#{node_name}"
      node.vm.network "private_network", ip: ip_prefix + "#{ip_last_term_start + i}"

      node.vm.provider "virtualbox" do |vb|
        vb.cpus = vagrant_settings["boxes"]["workernodes"]["cpus"]
        vb.memory = vagrant_settings["boxes"]["workernodes"]["memory"]
      end

      node.vm.box = vm_box
      node.vm.box_version = vm_box_version

      node.vm.provision "shell", path: "scripts/common.bash"
      node.vm.provision "shell", path: "scripts/setup-workernode.bash"
    end
  end
end
