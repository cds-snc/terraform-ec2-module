resource "aws_vpc_endpoint" "dynamodb" {
  count = var.read_dynamodb ? 1 : 0
  vpc_id            = aws_vpc.main.id
  vpc_endpoint_type = "Gateway"
  service_name      = "com.amazonaws.ca-central-1.dynamodb"
  route_table_ids   = [aws_vpc.main.default_route_table_id]
}