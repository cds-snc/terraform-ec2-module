resource "aws_vpc" "main" {

  cidr_block         = var.cidr_block
  enable_dns_support = true
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
  
  ingress {
    description = "SSH into VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}_default_sg"
  }
}
