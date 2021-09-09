provider "aviatrix" {
  controller_ip = "howdy-partner-avx-controller.aviatrixlab.com"
}

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aviatrix = {
      source  = "aviatrixsystems/aviatrix"
      version = "~> 2.20.0"
    }
  }

  # Matching config for terraform cloud
  backend "remote" {
    organization = "jb-smoker"

    workspaces {
      name = "aws-howdy-partner-twitch"
    }
  }
}
