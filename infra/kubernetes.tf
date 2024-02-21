resource "ovh_cloud_project_kube" "cluster" {
  name         = "${terraform.workspace}-cluster"
  region       = var.k8s_cluster_region
  version      = var.k8s_cluster_version
  private_network_id = openstack_networking_network_v2.network.id

  private_network_configuration {
      default_vrack_gateway              = var.gateway_ip
      private_network_routing_as_default = true
  }

   depends_on         = [openstack_networking_floatingip_associate_v2.associate]
}

resource "ovh_cloud_project_kube_nodepool" "pool" {
  kube_id        = ovh_cloud_project_kube.cluster.id
  name           = "${terraform.workspace}-instance"
  flavor_name    = var.k8s_nodepool_flavor
  monthly_billed = var.k8s_nodepool_monthly_billed
  min_nodes      = var.k8s_nodepool_min_nodes
  max_nodes      = var.k8s_nodepool_max_nodes
  desired_nodes  = var.k8s_nodepool_desired_nodes
  autoscale      = var.k8s_nodepool_autoscale

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  depends_on         = [ovh_cloud_project_kube_iprestrictions.allowed_ips]
}

resource "ovh_cloud_project_kube_iprestrictions" "allowed_ips" {
  kube_id = ovh_cloud_project_kube.cluster.id
  ips     = var.k8s_allowed_ips
}

output "kubeconfig" {
  value       = ovh_cloud_project_kube.cluster.kubeconfig
  description = "The kubeconfig to access the cluster"
  sensitive = true
}

output "nodesurl" {
  description = "The URL to access the cluster nodes"
  value       = ovh_cloud_project_kube.cluster.nodes_url
}

output "url" {
  value       = ovh_cloud_project_kube.cluster.url
  description = "The URL to access the cluster"
}
