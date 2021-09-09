variable "aws_account_id" {}
variable "ctl_password" {}
variable "ctl_user" {}

# Tags applied to all infrastucture
variable "common_tags" {
  default = {
    Project   = "aws-howdy-partner-twitch"
    Team      = "aviatrix solutions engineering"
    Terraform = true
  }
}
