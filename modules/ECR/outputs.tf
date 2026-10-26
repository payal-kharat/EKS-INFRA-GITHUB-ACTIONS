output "ECR_REPOSITORY_URLS" {
  description = "Map of repository names to repository URLs"
  value       = { for NAME, REPO in aws_ecr_repository.REPOSITORIES : NAME => REPO.repository_url }
}

output "ECR_REPOSITORY_ARNS" {
  description = "Map of repository names to repository ARNs"
  value       = { for NAME, REPO in aws_ecr_repository.REPOSITORIES : NAME => REPO.arn }
}