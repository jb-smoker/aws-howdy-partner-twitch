# Stand-alone resources

resource "aviatrix_gateway" "us_east_1_psf" {
  cloud_type                     = 1
  account_name                   = "aws-pod100"
  gw_name                        = "us-east-1-psf-gw-1"
  vpc_id                         = module.regional_network["us-east-1"].spoke_1_vpc.vpc_id
  vpc_reg                        = "us-east-1"
  gw_size                        = "t3.micro"
  subnet                         = "10.1.16.64/26"
  zone                           = "us-east-1a"
  enable_public_subnet_filtering = true
  public_subnet_filtering_route_tables = [
    module.regional_network["us-east-1"].spoke_1_vpc.route_tables[2],
    module.regional_network["us-east-1"].spoke_1_vpc.route_tables[3]
  ]
  public_subnet_filtering_guard_duty_enforced = true
  single_az_ha                                = true
  enable_encrypt_volume                       = true
  tags                                        = var.common_tags
}

# Workload instance(s)
# module "workload_instance_us_east_1" {
#   source           = "./workload_instance"
#   keypair_name     = "smoker"
#   subnet_id        = module.regional_network["us-east-1"].spoke_2_vpc.private_subnets[0].subnet_id
#   vpc_id           = module.regional_network["us-east-1"].spoke_2_vpc.vpc_id
#   instance_profile = aws_iam_instance_profile.ec2_role_for_ssm.name
#   common_tags      = var.common_tags
# }

# module "workload_instance_eu_central_1" {
#   source           = "./workload_instance"
#   keypair_name     = "smoker"
#   subnet_id        = module.regional_network["eu-central-1"].spoke_2_vpc.private_subnets[0].subnet_id
#   vpc_id           = module.regional_network["eu-central-1"].spoke_2_vpc.vpc_id
#   instance_profile = aws_iam_instance_profile.ec2_role_for_ssm.name
#   common_tags      = var.common_tags
#   providers = {
#     aws = aws.eu-central-1
#   }
# }

# module "workload_instance_ap_southeast_2" {
#   source           = "./workload_instance"
#   keypair_name     = "smoker"
#   subnet_id        = module.regional_network["ap-southeast-2"].spoke_2_vpc.private_subnets[0].subnet_id
#   vpc_id           = module.regional_network["ap-southeast-2"].spoke_2_vpc.vpc_id
#   instance_profile = aws_iam_instance_profile.ec2_role_for_ssm.name
#   common_tags      = var.common_tags
#   providers = {
#     aws = aws.ap-southeast-2
#   }
# }
