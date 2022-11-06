############################################################
# Configuration for the provider used by terraform
# i.e: AWS provider - resources will be created on AWS
############################################################

provider "aws" {
  region = var.region
}


############################################################
#  Remote state in terraform cloud
############################################################

terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.38.0"
    }
  }
  
  cloud {
    organization = "andrei"

    workspaces {
      #CLI-driven workflow
      #name = "terraform-cloud-aws-cli"     
      #Version Control workflow
      name = "terraform-cloud-aws-github"
    }
  }
}