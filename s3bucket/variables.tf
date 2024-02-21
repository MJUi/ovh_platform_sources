variable "region" {
  type    = string
  default = "gra"
}

variable "s3_endpoint" {
  type    = string
  default = "https://s3.gra.io.cloud.ovh.net"
}

variable "user_desc_prefix" {
  type    = string
  default = "[TF] User created by s3 terraform script"
}

variable "bucket_name" {
  type    = string
  default = "tf-s3-state"
}