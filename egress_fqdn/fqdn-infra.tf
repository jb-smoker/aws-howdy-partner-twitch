resource "aviatrix_fqdn" "howdy_partner" {
  fqdn_tag            = "allow_egress"
  fqdn_enabled        = true
  fqdn_mode           = "white"
  manage_domain_names = false

  gw_filter_tag_list {
    gw_name = "avx-us-east-1-spoke-2"
  }
  gw_filter_tag_list {
    gw_name = "avx-eu-central-1-spoke-2"
  }
  gw_filter_tag_list {
    gw_name = "avx-ap-southeast-2-spoke-2"
  }
}

resource "aviatrix_fqdn_tag_rule" "tcp" {
  for_each      = local.egress_rules.tcp
  fqdn_tag_name = aviatrix_fqdn.howdy_partner.fqdn_tag
  fqdn          = each.key
  protocol      = "tcp"
  port          = each.value
  depends_on    = [aviatrix_fqdn.howdy_partner]
}

resource "aviatrix_fqdn_tag_rule" "udp" {
  for_each      = local.egress_rules.udp
  fqdn_tag_name = aviatrix_fqdn.howdy_partner.fqdn_tag
  fqdn          = each.key
  protocol      = "udp"
  port          = each.value
  depends_on    = [aviatrix_fqdn.howdy_partner]
}
