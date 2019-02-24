provider "libvirt" {
    uri = "qemu:///system"
}

resource "libvirt_network" "ipsec_net" {
  name = "ipsec_net"
  mode = "nat"

  #  the domain used by the DNS server in this network
  domain = "ipsec.local"

  #  list of subnets the addresses allowed for domains connected
  # also derived to define the host addresses
  # also derived to define the addresses served by the DHCP server
  addresses = ["10.17.3.0/24"]

  # (Optional) DNS configuration
  dns {
    local_only = true
  }
}

resource "libvirt_volume" "east-vm-root-disk" {
  name = "east-vm-root-disk"
  source = "http://127.0.0.1:8089/east.qcow2"
}

resource "libvirt_domain" "east" {
  name = "east"
  memory = "4096"
  vcpu = 2

  disk {
    volume_id = "${libvirt_volume.east-vm-root-disk.id}"
  }

  network_interface {
    network_id = "${libvirt_network.ipsec_net.id}"
    hostname = "east"
    addresses = ["10.17.3.3"]
    mac = "AA:BB:CC:11:22:22"
    wait_for_lease = true
  }
}

# resource "libvirt_domain" "west" {
#   name = "west"
#   memory = "4096"
#   vcpu = 2
# }
