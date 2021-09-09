variable "keypair_name" {
  description = "ssh keypair name"
}

variable "subnet_id" {
  description = "subnet id for instance deployment"
}

variable "vpc_id" {
  description = "vpc id for instance deployment"
}

variable "instance_profile" {
  description = "ec2 iam instance profile for ssm access"
}

variable "common_tags" {
  description = "tags applied to all infrastructure"
}
