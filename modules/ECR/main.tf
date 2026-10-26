resource "aws_ecr_repository" "REPOSITORIES" {
  for_each             = toset(var.ECR_REPOSITORY_NAMES)
  name                 = each.value
  image_tag_mutability = var.IMAGE_TAG_MUTABILITY

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  force_delete = false
}