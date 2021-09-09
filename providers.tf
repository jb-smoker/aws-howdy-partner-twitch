terraform {
  required_providers {
    aviatrix = {
      source  = "aviatrixsystems/aviatrix"
      version = "~> 2.20.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aviatrix" {
  username                = var.ctl_user
  password                = var.ctl_password
  controller_ip           = "howdy-partner-avx-controller.aviatrixlab.com"
  skip_version_validation = false
}

provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/lab-admin"
  }
}

provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/lab-admin"
  }
}
