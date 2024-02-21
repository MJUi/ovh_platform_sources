terraform {
  backend "s3" {
    bucket                      = "tf-s3-state"
    key                         = "terraform.tfstate"
    region                      = "gra"
    endpoint                    = "s3.gra.io.cloud.ovh.net"
    access_key                  = "24f69437947d43538a163a57a2275101"
    secret_key                  = "228e29bbc0a64c5b861df164b5690694"
    skip_credentials_validation = true
    skip_region_validation      = true
  }
required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "~> 0.34.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.49.0"
    }
    utils = {
      source = "cloudposse/utils"
      version = "1.15.0"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = ovh_cloud_project_kube.cluster.kubeconfig_attributes[0].host
    client_certificate     = base64decode(ovh_cloud_project_kube.cluster.kubeconfig_attributes[0].client_certificate)
    client_key             = base64decode(ovh_cloud_project_kube.cluster.kubeconfig_attributes[0].client_key)
    cluster_ca_certificate = base64decode(ovh_cloud_project_kube.cluster.kubeconfig_attributes[0].cluster_ca_certificate)
  }
}
provider "kubectl" {
  host                   = ovh_cloud_project_kube.cluster.kubeconfig_attributes[0].host
  client_certificate     = base64decode(ovh_cloud_project_kube.cluster.kubeconfig_attributes[0].client_certificate)
  client_key             = base64decode(ovh_cloud_project_kube.cluster.kubeconfig_attributes[0].client_key)
  cluster_ca_certificate = base64decode(ovh_cloud_project_kube.cluster.kubeconfig_attributes[0].cluster_ca_certificate)
  load_config_file       = false
}
provider "kubernetes" {
  host                   = ovh_cloud_project_kube.cluster.kubeconfig_attributes[0].host
  client_certificate     = base64decode(ovh_cloud_project_kube.cluster.kubeconfig_attributes[0].client_certificate)
  client_key             = base64decode(ovh_cloud_project_kube.cluster.kubeconfig_attributes[0].client_key)
  cluster_ca_certificate = base64decode(ovh_cloud_project_kube.cluster.kubeconfig_attributes[0].cluster_ca_certificate)
}
provider "openstack" {
  auth_url    = "https://auth.cloud.ovh.net/v3/"
  domain_name = "default"
  region = var.k8s_cluster_region
}
provider "utils" {
}
provider "ovh" {
  endpoint = "ovh-eu"
}