variable "AWS_REGION" {
  description = "AWS deployment region"
  type        = string
  default     = "us-east-1"
}
variable "GITHUB_OWNER" {
  description = "GitHub username or organization"
  type        = string
}

variable "GITHUB_REPOSITORY" {
  description = "GitHub repository containing the application and workflows"
  type        = string
}

variable "GITHUB_BRANCH" {
  description = "Branch permitted to assume the GitHub Actions role"
  type        = string
  default     = "main"
}

variable "IAM_ROLE_NAME" {
  description = "IAM role name for GitHub Actions"
  type        = string
  default     = "employee-mgm-github-actions-role"
}

variable "ECR_REPOSITORY_PREFIX" {
  description = "Prefix for existing ECR application repositories"
  type        = string
  default     = "employee-mgm-"
}

variable "EKS_CLUSTER_NAMES" {
  description = "Existing EKS cluster names for the application"
  type        = list(string)
}

# EKS

variable "EKS_CLUSTER_NAME" {
  description = "Existing shared EKS cluster name"
  type        = string
}

variable "KUBERNETES_NAMESPACES" {
  description = "Application namespaces managed by GitHub Actions"
  type        = list(string)
}

