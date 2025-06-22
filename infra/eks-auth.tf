# # Configure aws-auth ConfigMap to allow access to EKS cluster
# resource "kubernetes_config_map" "aws_auth" {
#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }

#   data = {
#     mapRoles = yamlencode([
#       {
#         rolearn  = aws_iam_role.eks_cluster.arn
#         username = "system:node:{{EC2PrivateDNSName}}"
#         groups = [
#           "system:bootstrappers",
#           "system:nodes"
#         ]
#       },
#       {
#         rolearn  = aws_iam_role.eks_nodes.arn
#         username = "system:node:{{EC2PrivateDNSName}}"
#         groups = [
#           "system:bootstrappers",
#           "system:nodes"
#         ]
#       },
#       {
#         # Add your current IAM role for admin access
#         rolearn  = "arn:aws:iam::076680484948:role/Admin"
#         username = "admin"
#         groups = [
#           "system:masters"
#         ]
#       }
#     ])
#   }

#   depends_on = [aws_eks_cluster.main]
# }