output "transit" {
  description = "The Aviatrix transit gateway object with all of it's attributes"
  value       = module.transit.transit_gateway
}

output "spoke_1" {
  description = "The Aviatrix spoke gateway object with all of it's attributes"
  value       = module.spoke_1.spoke_gateway
}

output "spoke_1_vpc" {
  description = "The Aviatrix spoke gateway vpc object with all of it's attributes"
  value       = module.spoke_1.vpc
}

output "spoke_2" {
  description = "The Aviatrix spoke gateway object with all of it's attributes"
  value       = module.spoke_2.spoke_gateway
}

output "spoke_2_vpc" {
  description = "The Aviatrix spoke gateway vpc object with all of it's attributes"
  value       = module.spoke_2.vpc
}
