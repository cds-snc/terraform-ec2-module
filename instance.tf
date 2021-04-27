### AWS INSTANCE

resource "aws_instance" "dev_work" {
  depends_on                  = [aws_internet_gateway.gw]
  ami                         = var.ami_id == null ? data.aws_ami.ubuntu.id : var.ami_id
  associate_public_ip_address = false

  metadata_options {
    http_tokens = required
  }

  network_interface {
    network_interface_id = aws_network_interface.ni.id
    device_index         = 0
  }

  instance_type = var.instance_type

  key_name = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "${var.name}_instance"
    Created = timestamp()
  }

  root_block_device {
    encrypted   = true
    volume_size = 100
  }
}

resource "aws_eip" "ec2" {
  vpc = true
}

resource "aws_network_interface" "ni" {
  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.ec2.id]

  tags = {
    Name = "${var.name}_network_interface"
  }

}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.dev_work.id
  allocation_id = aws_eip.ec2.id
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "dev_key"
  public_key = var.ssh_public_key
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

