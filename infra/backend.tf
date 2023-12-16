terraform {
  backend "s3" {
    bucket  = "kunduso-terraform-remote-bucket"
    encrypt = true
    key     = "tf/aws-eks-terraform/terraform.tfstate"
    region  = "us-east-2"
  }
}