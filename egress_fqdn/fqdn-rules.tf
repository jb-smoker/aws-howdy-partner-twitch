# Software engineers modify this file only
locals {
  egress_rules = {
    tcp = {
      "*.amazonaws.com" = "443"
      "*.aviatrix.com"  = "443"
      # "*.espn.com"     = "443"
      # "*.cnn.com"      = "443"
    }
    udp = {
      "dns.google.com" = "53"
    }
  }
}
