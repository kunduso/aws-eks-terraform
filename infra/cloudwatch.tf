resource "aws_cloudwatch_log_group" "eks_cluster" {
  name              = "/aws/eks/${var.name}-cluster/cluster"
  retention_in_days = 7

  tags = {
    Name        = "${var.name}-eks-cloudwatch-log-group"
    Environment = "study"
  }
}