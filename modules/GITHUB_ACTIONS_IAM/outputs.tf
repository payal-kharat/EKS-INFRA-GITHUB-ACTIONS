
output "GITHUB_ACTIONS_ROLE_ARN" {
  description = "IAM role ARN assumed by GitHub Actions"
  value       = aws_iam_role.GITHUB_ACTIONS.arn
}

output "GITHUB_OIDC_PROVIDER_ARN" {
  description = "GitHub OIDC identity provider ARN"
  value       = data.aws_iam_openid_connect_provider.GITHUB.arn
}

output "ECR_POLICY_ARN" {
  description = "IAM policy ARN for ECR access"
  value       = aws_iam_policy.ECR_ACCESS.arn
}

output "EKS_DESCRIBE_POLICY_ARN" {
  description = "IAM policy ARN for EKS cluster descriptions"
  value       = aws_iam_policy.EKS_DESCRIBE.arn
}
