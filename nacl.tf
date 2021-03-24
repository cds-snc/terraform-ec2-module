# NACL
# resource "aws_network_acl" "nacl" {

#   vpc_id = aws_vpc.main.id
#   subnet_ids = [aws_subnet.public.id]
#   tags = {
#     Name = "${var.name}_public_nacl"
#   }
# }

# resource "aws_network_acl_rule" "SSH" { 
#   network_acl_id = aws_network_acl.nacl.id
#   rule_number = 100
#   egress = false
#   protocol = "tcp"
#   rule_action = "allow"
#   cidr_block = aws_vpc.main.cidr_block
#   from_port = 22
#   to_port = 22
# }

# resource "aws_network_acl_rule" "Ephemeral" { 
#   network_acl_id = aws_network_acl.nacl.id
#   rule_number = 101
#   egress = false
#   protocol = "tcp"
#   rule_action = "allow"
#   cidr_block = aws_vpc.main.cidr_block
#   from_port = 1024
#   to_port = 65535
# }

# resource "aws_network_acl_rule" "allow_egress" { 
#   network_acl_id = aws_network_acl.nacl.id
#   rule_number = 102
#   egress = true
#   protocol = "all"
#   rule_action = "allow"
#   cidr_block = "0.0.0.0/0"
# }


resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.main.default_network_acl_id
  subnet_ids = [aws_subnet.public.id]

  tags = { 
    Name = "${var.name}_default_nacl"
  }
  ingress { 
    
    rule_no = 100
    protocol = "tcp"
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 22
    to_port = 22

  }

  ingress { 

    rule_no = 101
    protocol = "tcp"
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 1024
    to_port = 65535

  }

  egress { 

    rule_no = 102
    protocol = -1
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
  # no rules defined, deny all traffic in this ACL
}