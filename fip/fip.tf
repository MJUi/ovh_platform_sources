resource "openstack_networking_floatingip_v2" "floatip" {
  pool    = "Ext-Net"
  count = "${var.n_fips > 0 ? var.n_fips : 0}"
}

output "fip" {
  value = length(openstack_networking_floatingip_v2.floatip) > 0 ? openstack_networking_floatingip_v2.floatip[*].address : []
}
