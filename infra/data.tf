data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  cluster_name = "gene-ai-eks-${random_string.suffix.result}"
  s3_bucket_name = "${data.aws_caller_identity.current.account_id}-gene-ai"
  vpc_name = "gene-ai-vpc"
  dynamodb_table_name = "${data.aws_caller_identity.current.account_id}-gene-ai-table"
}
