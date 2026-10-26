
variable "AWS_REGION" {
  description = "AWS region containing the EKS cluster"
  type        = string
}

variable "EKS_CLUSTER_NAME" {
  description = "Name of the existing EKS cluster"
  type        = string
}

variable "GITHUB_ACTIONS_ROLE_ARN" {
  description = "IAM role ARN created by the GITHUB_ACTIONS_IAM module"
  type        = string
}

variable "KUBERNETES_NAMESPACES" {
  description = "Namespaces where GitHub Actions can deploy"
  type        = list(string)
}
