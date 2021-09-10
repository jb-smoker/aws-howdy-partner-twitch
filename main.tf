locals {
  # Aws region(s) | cidr(s) for network deployment
  region = {
    us-east-1 = "10.1.0.0/16"
    # eu-central-1   = "10.2.0.0/16"
    # ap-southeast-2 = "10.3.0.0/16"
    # us-west-2      = "10.4.0.0/16"
    # sa-east-1      = "10.5.0.0/16"
    # ap-northeast-1 = "10.6.0.0/16"
    # ap-south-1     = "10.7.0.0/16"
  }
  # Avx transit peering pairs
  transit_peering = {
    # us-east-1-eu-central-1      = ["us-east-1", "eu-central-1"]
    # eu-central-1-ap-southeast-2 = ["eu-central-1", "ap-southeast-2"]
    # us-west-2-ap-southeast-2    = ["us-west-2", "ap-southeast-2"]
    # us-east-1-us-west-2         = ["us-east-1", "us-west-2"]
    # us-west-2-sa-east-1         = ["us-west-2", "sa-east-1"]
    # eu-central-1-ap-northeast-1 = ["eu-central-1", "ap-northeast-1"]
    # eu-central-1-ap-south-1     = ["eu-central-1", "ap-south-1"]
  }
}

# The regional network module builds 1 transit and 2 connected spoke vpc(s)
module "regional_network" {
  for_each    = local.region
  source      = "./regional_network"
  cidr        = each.value
  region      = each.key
  account     = "aws-pod100"
  common_tags = var.common_tags
}

# Peer designated regional transits
resource "aviatrix_transit_gateway_peering" "connected" {
  for_each              = local.transit_peering
  transit_gateway_name1 = module.regional_network[each.value[0]].transit.gw_name
  transit_gateway_name2 = module.regional_network[each.value[1]].transit.gw_name
}
