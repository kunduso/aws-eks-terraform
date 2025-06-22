resource "aws_security_group" "eks_cluster" {
  name        = "${var.name}-eks-cluster-sg"
  description = "Security group for EKS cluster control plane"
  vpc_id      = module.vpc.vpc.id
  tags = {
    Name = "${var.name}-eks-cluster-sg"
  }
}

# Cluster egress rules
resource "aws_security_group_rule" "cluster_https_egress" {
  description       = "HTTPS egress for cluster"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_cluster.id
  type              = "egress"
}

