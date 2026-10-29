
resource "aws_eks_addon" "VPC_CNI" {
  cluster_name = var.EKS_CLUSTER_NAME
  addon_name   = "vpc-cni"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-vpc-cni"
    }
  )
}

resource "aws_eks_addon" "COREDNS" {
  cluster_name = var.EKS_CLUSTER_NAME
  addon_name   = "coredns"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-coredns"
    }
  )

  depends_on = [
    aws_eks_addon.VPC_CNI
  ]
}

resource "aws_eks_addon" "KUBE_PROXY" {
  cluster_name = var.EKS_CLUSTER_NAME
  addon_name   = "kube-proxy"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = merge(
    var.COMMON_TAGS,
    {
      Name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-kube-proxy"
    }
  )

  depends_on = [
    aws_eks_addon.VPC_CNI
  ]
}

# resource "aws_eks_addon" "EBS_CSI" {
#   cluster_name = var.EKS_CLUSTER_NAME
#   addon_name   = "aws-ebs-csi-driver"

#   service_account_role_arn = var.EBS_CSI_ROLE_ARN

#   resolve_conflicts_on_create = "OVERWRITE"
#   resolve_conflicts_on_update = "OVERWRITE"

#   tags = merge(
#     var.COMMON_TAGS,
#     {
#       Name = "${var.PROJECT_NAME}-${var.ENVIRONMENT}-ebs-csi"
#     }
#   )

#   depends_on = [
#     aws_eks_addon.VPC_CNI
#   ]
# }

