resource "aws_dynamodb_table" "dynamodb-table" {
  name         = local.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"
  range_key    = "BloodGroup"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "BloodGroup"
    type = "S"
  }
  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  tags = {
    Name = local.dynamodb_table_name
  }
}

resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.us-east-2.dynamodb"
  vpc_endpoint_type = "Gateway"
}

resource "aws_vpc_endpoint_route_table_association" "rt_association_db" {
  route_table_id  = module.vpc.private_route_table_ids[0]
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb_endpoint.id
}