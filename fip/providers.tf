terraform {
  backend "s3" {
    bucket                      = "tf-s3-state"
    key                         = "init.tfstate"
    skip_credentials_validation = true
    skip_region_validation      = true
  }
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.49.0"
    }
  }
}

provider "openstack" {
  auth_url    = "https://auth.cloud.ovh.net/v3/"
  domain_name = "default"
  region      = var.region
}