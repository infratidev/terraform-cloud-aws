#####################################################
# VPC Requirement
#####################################################

variable "infracode_vpc" {
  description = "VPC for testing environment"
  type        = string
  default     = "10.0.0.0/16"
}

#####################################################
# EC2 Requirement
#####################################################

variable "instance_tenancy" {
  description = "it defines the tenancy of VPC. Whether it's defsult or dedicated"
  type        = string
  default     = "default"
}

variable "instance_type" {
  description = "Instance type to create an instance"
  type        = string
  default     = "t2.micro"
}

variable "region" {
    description = "Default region"
    default = "us-east-1"
}

#####################################################
# Public subnet CIDR
#####################################################

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
  default     = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}

#####################################################
# DNS
#####################################################

variable "public_dns_name" {
    description = "public_dns_name"
    default = "sres.dev"
}

variable "public_dns_hostname" {
    description = "public_dns_name"
    default = "infracode"
}







