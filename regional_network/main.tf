# A very simple transit and 2 spoke vpc(s) architecture in a single aws region
module "transit" {
  source              = "terraform-aviatrix-modules/aws-transit/aviatrix"
  version             = "v4.0.3"
  account             = var.account
  cidr                = cidrsubnet(var.cidr, 4, 0)
  enable_segmentation = true
  ha_gw               = false
  instance_size       = "t3.micro"
  region              = var.region
  tags                = var.common_tags
}

module "spoke_1" {
  source        = "terraform-aviatrix-modules/aws-spoke/aviatrix"
  version       = "4.0.3"
  account       = var.account
  attached      = false
  cidr          = cidrsubnet(var.cidr, 4, 1)
  ha_gw         = false
  instance_size = "t3.micro"
  name          = "${var.region}-spoke-1"
  region        = var.region
  suffix        = false
  tags          = var.common_tags
}

module "spoke_2" {
  source        = "terraform-aviatrix-modules/aws-spoke/aviatrix"
  version       = "4.0.3"
  account       = var.account
  attached      = false
  cidr          = cidrsubnet(var.cidr, 4, 2)
  ha_gw         = false
  instance_size = "t3.micro"
  name          = "${var.region}-spoke-2"
  region        = var.region
  suffix        = false
  tags          = var.common_tags
}

# Attach the spoke gws to the transit gw
resource "aviatrix_spoke_transit_attachment" "spoke_1" {
  spoke_gw_name   = module.spoke_1.spoke_gateway.gw_name
  transit_gw_name = module.transit.transit_gateway.gw_name
}

resource "aviatrix_spoke_transit_attachment" "spoke_2" {
  spoke_gw_name   = module.spoke_2.spoke_gateway.gw_name
  transit_gw_name = module.transit.transit_gateway.gw_name
}
