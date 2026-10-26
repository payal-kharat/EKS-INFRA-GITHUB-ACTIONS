output "EKS_ACCESS_ENTRY_ID" {
  description = "EKS access entry identifier"
  value       = "${aws_eks_access_entry.GITHUB_ACTIONS.cluster_name}:${aws_eks_access_entry.GITHUB_ACTIONS.principal_arn}"
}

output "EKS_ACCESS_POLICY_ASSOCIATION_ID" {
  description = "EKS access policy association identifier"
  value       = aws_eks_access_policy_association.GITHUB_ACTIONS.id
}

output "EKS_ACCESS_PRINCIPAL_ARN" {
  description = "IAM principal granted access to EKS"
  value       = aws_eks_access_entry.GITHUB_ACTIONS.principal_arn
}