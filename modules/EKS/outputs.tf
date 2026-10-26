output "EKS_CLUSTER_NAME" {
  value = aws_eks_cluster.EKS.name
}

output "EKS_CLUSTER_ARN" {
  value = aws_eks_cluster.EKS.arn
}

output "EKS_CLUSTER_ENDPOINT" {
  value = aws_eks_cluster.EKS.endpoint
}

output "EKS_OIDC_PROVIDER_ARN" {
  value = aws_iam_openid_connect_provider.EKS.arn
}

output "EKS_OIDC_ISSUER_URL" {
  value = aws_eks_cluster.EKS.identity[0].oidc[0].issuer
}

output "EKS_NODE_GROUP_NAME" {
  value = aws_eks_node_group.EKS.node_group_name
}

output "EBS_CSI_ROLE_ARN" {
  value = aws_iam_role.EBS_CSI.arn
}
output "EKS_CLUSTER_CERTIFICATE_AUTHORITY_DATA" {
  value = aws_eks_cluster.EKS.certificate_authority[0].data
}

