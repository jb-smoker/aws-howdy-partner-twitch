# Software engineers modify this file only
locals {
  egress_rules = {
    tcp = {
      "*.amazonaws.com" = "443"
      "*.aviatrix.com"  = "443"
      # "*.terraform.io"  = "443"
      # "*.onug.net"      = "443"
    }
    udp = {
      # "dns.google.com" = "53"
    }
  }
}
