variable "cidr" {
  description = "cidr value for the regional network"
}

variable "region" {
  description = "aws region for the regional network"
}

variable "account" {
  description = "the aws account name onboarded to aviatrix"
}

variable "common_tags" {
  description = "tags applied to all infrastructure"
}
