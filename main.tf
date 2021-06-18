resource "aws_vpc" "main" {

  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}_vpc"
  }

}

resource "aws_subnet" "public" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}_public_subnet"
  }

  cidr_block              = var.cidr_block
  map_public_ip_on_launch = var.auto_public_ip
}

resource "aws_internet_gateway" "gw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}_internet_gateway"
  }

}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id
}


locals {
  disabled_rule = {
    enabled     = false
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = []
  }

  sg_ingress_list = {
    ssh = var.enable_ssh ? {
      enabled     = true
      description = "SSH into VPC"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    } : local.disabled_rule
  }
}

resource "aws_security_group" "ec2" {
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = [for i in local.sg_ingress_list :
      {
        enabled     = i.enabled
        description = i.description
        from_port   = i.from_port
        to_port     = i.to_port
        protocol    = i.protocol
        cidr_blocks = i.cidr_blocks
      } if i.enabled == true
    ]

    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}_ec2_sg"
  }
}
