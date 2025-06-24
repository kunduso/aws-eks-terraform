# KMS key for CloudWatch logs encryption
resource "aws_kms_key" "cloudwatch_kms_key" {
  description             = "KMS key for CloudWatch logs encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name = "${var.name}-encrypt-cloudwatch-logs"
  }
}

resource "aws_kms_key_policy" "cloudwatch_key_policy" {
  key_id = aws_kms_key.cloudwatch_kms_key.key_id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow CloudWatch Logs"
        Effect = "Allow"
        Principal = {
          Service = "logs.${data.aws_region.current.name}.amazonaws.com"
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
        Condition = {
          ArnEquals = {
            "kms:EncryptionContext:aws:logs:arn" = "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/eks/${var.name}-cluster/cluster"
          }
        }
      }
    ]
  })
}

resource "aws_kms_alias" "cloudwatch_key_alias" {
  name          = "alias/${var.name}-encrypt-cloudwatch-logs"
  target_key_id = aws_kms_key.cloudwatch_kms_key.key_id
}

resource "aws_cloudwatch_log_group" "eks_cluster" {
  name              = "/aws/eks/${var.name}-cluster/cluster"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.cloudwatch_kms_key.arn

  tags = {
    Name        = "${var.name}-eks-cloudwatch-log-group"
    Environment = "study"
  }
}