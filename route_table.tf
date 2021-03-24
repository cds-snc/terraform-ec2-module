# Route Tables
# resource "aws_route_table" "rt" {
#   vpc_id = aws_vpc.main.id
#   tags = { 
#     Name = "${var.name}_route_table"
#   }
# }

# resource "aws_route" "igw" {
#   route_table_id         = aws_route_table.rt.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.gw.id
# }

# resource "aws_route_table_association" "a" {
#   subnet_id      = aws_subnet.public.id
#   route_table_id = aws_route_table.rt.id
# }

resource "aws_default_route_table" "r" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route { 
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.name}_default_route_table"
  }
}
resource "aws_route_table_association" "a" {
    subnet_id      = aws_subnet.public.id
    route_table_id = aws_default_route_table.r.id
}