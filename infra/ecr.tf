resource "aws_ecr_repository" "image_repo" {
  name                 = var.name
  image_tag_mutability = "IMMUTABLE"
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.ecr_kms_key.arn
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "${var.name}"
  }
}

# Add repository policy to allow EKS nodes to pull images
resource "aws_ecr_repository_policy" "repo_policy" {
  repository = aws_ecr_repository.image_repo.name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowPullFromEKSNodes",
        Effect = "Allow",
        Principal = {
          AWS = aws_iam_role.eks_nodes.arn
        },
        Action = [
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchCheckLayerAvailability"
        ]
      }
    ]
  })
}