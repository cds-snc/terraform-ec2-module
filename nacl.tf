resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.main.default_network_acl_id
  subnet_ids             = [aws_subnet.public.id]

  tags = {
    Name = "${var.name}_default_nacl"
  }
  ingress {

    rule_no    = 100
    protocol   = "tcp"
    action     = var.enable_ssh ? "allow" : "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22

  }

  ingress {

    rule_no    = 101
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535

  }

  egress {

    rule_no    = 102
    protocol   = -1
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  # no rules defined, deny all traffic in this ACL
}
