resource "aws_eks_cluster" "main" {
  name     = "${var.name}-cluster"
  role_arn = aws_iam_role.eks_cluster.arn
  version  = "1.31"

  vpc_config {
    security_group_ids      = [aws_security_group.eks_cluster.id]
    subnet_ids              = module.vpc.public_subnets[*].id
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_cloudwatch_log_group.eks_cluster
  ]

  tags = {
    Name = "${var.name}-cluster"
  }
  #checkov:skip=CKV_AWS_58: AWS EKS cluster does not have secrets encryption enabled.
  #reason-for-skip: This EKS cluster isn't using Secrets.
}