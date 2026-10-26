# EKS
output "EKS_ACCESS_ENTRY_ARN" {
  description = "GitHub Actions EKS access entry ARN"
  value       = module.EKS_ACCESS.EKS_ACCESS_ENTRY_ARN
}

output "EKS_ACCESS_POLICY_ASSOCIATION_ID" {
  description = "GitHub Actions EKS policy association ID"
  value       = module.EKS_ACCESS.EKS_ACCESS_POLICY_ASSOCIATION_ID
}

output "EKS_ACCESS_PRINCIPAL_ARN" {
  description = "IAM role authorized for Kubernetes deployment"
  value       = module.EKS_ACCESS.EKS_ACCESS_PRINCIPAL_ARN
}
