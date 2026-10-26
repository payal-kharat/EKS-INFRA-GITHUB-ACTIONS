output "EKS_OIDC_PROVIDER_ARN" {
  value = aws_iam_openid_connect_provider.EKS.arn
}

output "EKS_OIDC_ISSUER_URL" {
  value = data.aws_eks_cluster.EXISTING.identity[0].oidc[0].issuer
}