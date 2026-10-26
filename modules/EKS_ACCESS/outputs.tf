
output "EKS_ACCESS_ENTRY_ARN" {
  description = "ARN of the GitHub Actions EKS access entry"
  value       = aws_eks_access_entry.GITHUB_ACTIONS.arn
}

output "EKS_ACCESS_POLICY_ASSOCIATION_ID" {
  description = "ID of the associated EKS access policy"
  value       = aws_eks_access_policy_association.GITHUB_ACTIONS.id
}

output "EKS_ACCESS_PRINCIPAL_ARN" {
  description = "IAM role authorized to access EKS"
  value       = aws_eks_access_entry.GITHUB_ACTIONS.principal_arn
}
