resource "openstack_networking_network_v2" "network" {
  name           = "${terraform.workspace}-network"
  admin_state_up = "true"
  region         = var.k8s_cluster_region
}

resource "openstack_networking_subnet_v2" "subnet" {
  network_id      = openstack_networking_network_v2.network.id
  name            = "${terraform.workspace}-subnet"
  region          = var.k8s_cluster_region
  cidr            = var.network
  enable_dhcp     = true
  no_gateway      = false

  allocation_pool {
    start = var.net_start
    end   = var.net_end
  }
}

data "openstack_networking_network_v2" "ext_net" {
  name   = "Ext-Net"
  region = var.k8s_cluster_region
}

resource "openstack_networking_router_v2" "gateway" {
  name                = "${terraform.workspace}-gateway"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.ext_net.id
  region              = var.k8s_cluster_region
}

resource "openstack_networking_router_interface_v2" "gateway_interface" {
  router_id = openstack_networking_router_v2.gateway.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
  region    = var.k8s_cluster_region
}

resource "openstack_lb_loadbalancer_v2" "lb_1" {
  name = "${terraform.workspace}-lb"
  vip_subnet_id = openstack_networking_subnet_v2.subnet.id
}

resource "openstack_networking_floatingip_associate_v2" "associate" {
  floating_ip = var.loadbalancer_ip
  port_id = openstack_lb_loadbalancer_v2.lb_1.vip_port_id
}

output "network_id" {
  value = openstack_networking_network_v2.network.id
}

output "subnet_id" {
  value = openstack_networking_subnet_v2.subnet.id
}

output "lb_id" {
  value = openstack_lb_loadbalancer_v2.lb_1.id
}
