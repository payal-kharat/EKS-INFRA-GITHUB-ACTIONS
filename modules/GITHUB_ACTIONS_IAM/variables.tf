
variable "AWS_REGION" {
  description = "AWS region where EKS and ECR are deployed"
  type        = string
}

variable "GITHUB_OWNER" {
  description = "GitHub organization or username that owns the repository"
  type        = string
}

variable "GITHUB_REPOSITORY" {
  description = "GitHub repository name containing the workflows"
  type        = string
}

variable "GITHUB_BRANCH" {
  description = "Branch permitted to assume the GitHub Actions IAM role"
  type        = string
  default     = "main"
}

# variable "IAM_ROLE_NAME" {
#   description = "Name of the GitHub Actions IAM role"
#   type        = string
#   default     = "employee-mgm-github-actions-role"
# }
variable "IAM_ROLE_ARN" {
  description = "ARN of the existing GitHub Actions IAM role"
  type        = string
}

variable "ECR_REPOSITORY_PREFIX" {
  description = "Prefix used by existing application ECR repositories"
  type        = string
  default     = "employee-mgm-"
}

variable "EKS_CLUSTER_NAMES" {
  description = "Existing EKS cluster names accessible to the workflow"
  type        = list(string)
}
