# Segmentation - Security Domains applied to all spokes in all regions
resource "aviatrix_segmentation_security_domain" "region_spoke_1" {
  for_each    = local.region
  domain_name = "${each.key}-spoke-1"
}

resource "aviatrix_segmentation_security_domain" "region_spoke_2" {
  for_each    = local.region
  domain_name = "${each.key}-spoke-2"
}

# Associate each spoke1 to its security domain and corresponding transit
resource "aviatrix_segmentation_security_domain_association" "spoke_1" {
  for_each             = local.region
  transit_gateway_name = module.regional_network[each.key].transit.gw_name
  security_domain_name = aviatrix_segmentation_security_domain.region_spoke_1[each.key].domain_name
  attachment_name      = module.regional_network[each.key].spoke_1.gw_name
}

resource "aviatrix_segmentation_security_domain_association" "spoke_2" {
  for_each             = local.region
  transit_gateway_name = module.regional_network[each.key].transit.gw_name
  security_domain_name = aviatrix_segmentation_security_domain.region_spoke_2[each.key].domain_name
  attachment_name      = module.regional_network[each.key].spoke_2.gw_name
}

# Connection policy to allow access from every spoke1 and us-east-1 spoke1
resource "aviatrix_segmentation_security_domain_connection_policy" "us_east_1_spoke_1" {
  for_each = {
    for key in aviatrix_segmentation_security_domain.region_spoke_1 :
    key.domain_name => key
    if key.domain_name != "us-east-1-spoke-1"
  }
  domain_name_1 = "us-east-1-spoke-1"
  domain_name_2 = each.key
}

# Connection policy to allow access from every spoke2 and us-east-1 spoke2
resource "aviatrix_segmentation_security_domain_connection_policy" "us_east_1_spoke_2" {
  for_each = {
    for key in aviatrix_segmentation_security_domain.region_spoke_2 :
    key.domain_name => key
    if key.domain_name != "us-east-1-spoke-2"
  }
  domain_name_1 = "us-east-1-spoke-2"
  domain_name_2 = each.key
}

# Connection policy to allow access from every spoke2 and us-east-1 spoke1
resource "aviatrix_segmentation_security_domain_connection_policy" "us_east_1_spoke_1_all" {
  for_each = {
    for key in aviatrix_segmentation_security_domain.region_spoke_2 :
    key.domain_name => key
  }
  domain_name_1 = "us-east-1-spoke-1"
  domain_name_2 = each.key
}

# Connection policy to allow access from every spoke1 and us-east-1 spoke2
resource "aviatrix_segmentation_security_domain_connection_policy" "us_east_1_spoke_2_all" {
  for_each = {
    for key in aviatrix_segmentation_security_domain.region_spoke_1 :
    key.domain_name => key
    if key.domain_name != "us-east-1-spoke-1"
  }
  domain_name_1 = "us-east-1-spoke-2"
  domain_name_2 = each.key
}
