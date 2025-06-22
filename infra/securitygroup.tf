resource "aws_security_group" "eks_cluster" {
  name        = "${var.name}-eks-cluster-sg"
  description = "Security group for EKS cluster control plane"
  vpc_id      = module.vpc.vpc.id
  tags = {
    Name = "${var.name}-eks-cluster-sg"
  }
}

resource "aws_security_group" "eks_nodes" {
  name        = "${var.name}-eks-nodes-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = module.vpc.vpc.id
  tags = {
    Name = "${var.name}-eks-nodes-sg"
  }
}

# Egress rule for cluster security group
resource "aws_security_group_rule" "cluster_egress" {
  description       = "Allow all outbound traffic from cluster"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_cluster.id
  type              = "egress"
}

# Egress rule for nodes security group
resource "aws_security_group_rule" "nodes_egress" {
  description       = "Allow all outbound traffic from nodes"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_nodes.id
  type              = "egress"
}

# Allow the cluster to communicate with the worker nodes
resource "aws_security_group_rule" "cluster_to_nodes" {
  description              = "Allow cluster to communicate with worker nodes"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_nodes.id
  source_security_group_id = aws_security_group.eks_cluster.id
  to_port                  = 65535
  type                     = "ingress"
}

# Allow the worker nodes to communicate with the cluster
resource "aws_security_group_rule" "nodes_to_cluster" {
  description              = "Allow worker nodes to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster.id
  source_security_group_id = aws_security_group.eks_nodes.id
  to_port                  = 443
  type                     = "ingress"
}

# Allow worker nodes to communicate with each other
resource "aws_security_group_rule" "nodes_internal" {
  description              = "Allow worker nodes to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_nodes.id
  source_security_group_id = aws_security_group.eks_nodes.id
  to_port                  = 65535
  type                     = "ingress"
}