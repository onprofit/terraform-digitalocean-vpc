## Managed By : CloudDrove
##Description : This Script is used to create VPC.
## Copyright @ CloudDrove. All Right Reserved.

# locals for regions
locals {
  region = {
    amsterdam-3 = "ams3"
    atlanta-1   = "atl1"
    bangalore-1 = "blr1"
    frankfurt-1 = "fra1"
    london-1    = "lon1"
    newyork-1   = "nyc1"
    newyork-2   = "nyc2"
    newyork-3   = "nyc3"
    francisco-2 = "sfo2"
    francisco-3 = "sfo3"
    singapore-1 = "sgp1"
    sydney-1    = "syd1"
    toronto-1   = "tor1"
  }
}

#Module      : LABEL
#Description : Terraform label module variables.
module "labels" {
  source      = "clouddrove/labels/digitalocean"
  version     = "0.15.0"
  name        = var.name
  environment = var.environment
  label_order = var.label_order

}

#Module      : VPC
#Description : VPCs are virtual networks containing resources that can communicate with each other in full isolation, using private IP addresses.
resource "digitalocean_vpc" "default" {
  count = var.enable_vpc == true ? 1 : 0

  name        = module.labels.id
  region      = coalesce(local.region[var.region], var.region)
  description = var.description
  ip_range    = var.ip_range
}