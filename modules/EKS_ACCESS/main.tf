
resource "aws_eks_access_entry" "GITHUB_ACTIONS" {
  cluster_name  = var.EKS_CLUSTER_NAME
  principal_arn = var.GITHUB_ACTIONS_ROLE_ARN
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "GITHUB_ACTIONS" {
  cluster_name  = var.EKS_CLUSTER_NAME
  principal_arn = var.GITHUB_ACTIONS_ROLE_ARN
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.GITHUB_ACTIONS]
}
