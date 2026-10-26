
resource "aws_eks_access_entry" "GITHUB_ACTIONS" {
  cluster_name      = var.EKS_CLUSTER_NAME
  principal_arn     = var.GITHUB_ACTIONS_ROLE_ARN
  type              = "STANDARD"
  kubernetes_groups = []
}

resource "aws_eks_access_policy_association" "GITHUB_ACTIONS" {
  cluster_name  = var.EKS_CLUSTER_NAME
  principal_arn = aws_eks_access_entry.GITHUB_ACTIONS.principal_arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSEditPolicy"

  access_scope {
    type       = "namespace"
    namespaces = var.KUBERNETES_NAMESPACES
  }
}


