resource "aws_ecr_repository" "gene_ai" {
  name                 = "gene-ai"
  image_tag_mutability = "IMMUTABLE"
  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.gene_ai.id
  }
  image_scanning_configuration {
    scan_on_push = true
  }
  lifecycle {
    ignore_changes = [encryption_configuration]
  }
}

resource "aws_kms_key" "gene_ai" {
  description             = "KMS key for Gene AI"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}
resource "aws_kms_alias" "gene_ai" {
    name          = "alias/gene_ai"
  target_key_id = aws_kms_key.gene_ai.key_id
}