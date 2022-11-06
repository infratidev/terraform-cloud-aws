###################################################
# Fetching all availability zones in us-east-1
###################################################

data "aws_availability_zones" "azs" {}

###################################################
# Fetching predefines IAM role
###################################################

###################################################
# AWS AMI
###################################################

data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-10-amd64-20210208-542"]
  }

  owners = ["136693071363"] # Debian 10

}