##########################################################################################
# Creating 3 EC2 Instances:
##########################################################################################

resource "aws_instance" "instance" {
  count                = length(aws_subnet.public_subnet.*.id)
  ami                  = data.aws_ami.debian.id 
  instance_type        = var.instance_type
  subnet_id            = element(aws_subnet.public_subnet.*.id, count.index)
  security_groups      = [aws_security_group.sg.id, ]

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  sudo echo "<h1> Welcome to my terraform infracode.dev IP: $(curl -s ifconfig.me) </h1>" | sudo tee "/var/www/html/index.html"
  echo "*** Completed Installing apache2"
  EOF

  tags = {
    "Name"        = "Instance-infracode-${count.index}"
    "Environment" = "DSV"
    "CreatedBy"   = "Terraform infracode.dev"
  }

  timeouts {
    create = "10m"
  }

}

############################################################################################
# Creating 3 Elastic IPs:
############################################################################################

resource "aws_eip" "eip" {
  count            = length(aws_instance.instance.*.id)
  instance         = element(aws_instance.instance.*.id, count.index)
  public_ipv4_pool = "amazon"
  vpc              = true

  tags = {
    "Name" = "EIP-${count.index}"
  }
}

############################################################################################
# Creating EIP association with EC2 Instances:
############################################################################################

resource "aws_eip_association" "eip_association" {
  count         = length(aws_eip.eip)
  instance_id   = element(aws_instance.instance.*.id, count.index)
  allocation_id = element(aws_eip.eip.*.id, count.index)
}