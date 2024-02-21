variable "k8s_cluster_region" {
  type        = string
  description = "The region to use for the cluster"
  default     = "SBG5"
}

variable "k8s_cluster_version" {
  type        = string
  description = "The version to use for the cluster"
  default     = "1.27"
}

variable "k8s_nodepool_flavor" {
  type        = string
  description = "The flavor to use for the nodepool"
  default     = "d2-4"
}

variable "k8s_nodepool_monthly_billed" {
  type        = bool
  description = "Whether the nodepool should be billed monthly or hourly"
  default     = false
}

variable "k8s_nodepool_min_nodes" {
  type        = number
  description = "The minimum number of nodes to use for the nodepool"
  default     = 3
}

variable "k8s_nodepool_max_nodes" {
  type        = number
  description = "The maximum number of nodes to use for the nodepool"
  default     = 10
}

variable "k8s_nodepool_desired_nodes" {
  type        = number
  description = "The desired number of nodes to use for the nodepool"
  default     = 3
}

variable "k8s_nodepool_autoscale" {
  type        = bool
  description = "Enable autoscaling feature (WIP)"
  default     = false
}

variable "k8s_allowed_ips" {
  type        = list
  description = "List of allowed IPs for the kube cluster"
  default     = []
}

variable "vlan_id" {
  type = string
}

variable "net_start" {
    type = string
}

variable "net_end" {
    type = string
}

variable "network" {
    type = string
}

variable "gateway_ip" {
	type = string
}

variable "loadbalancer_ip" {
  type = string
}

variable "argocd_version" {
  type        = string
  description = "The version of ArgoCD helm release to install"
  default     = "5.33.1"
}

variable "argocd_avp_version" {
  type        = string
  description = "ArgoCD argo-vault-plugin version"
  default     = "1.14.0"
}

variable "is_cluster_forge" {
  type = bool
  default = false
}