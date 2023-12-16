resource "aws_s3_bucket" "example" {
  bucket = local.s3_bucket_name

  tags = {
    Name        = local.s3_bucket_name
  }
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id = module.vpc.vpc_id
  service_name = "com.amazonaws.us-east-2.s3"
  vpc_endpoint_type = "Gateway"
}

resource "aws_vpc_endpoint_route_table_association" "rt_association" {
  route_table_id = module.vpc.private_route_table_ids[0]
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
}