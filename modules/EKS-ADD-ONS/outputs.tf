
output "VPC_CNI_ADDON_NAME" {
  value = aws_eks_addon.VPC_CNI.addon_name
}

output "VPC_CNI_ADDON_ARN" {
  value = aws_eks_addon.VPC_CNI.arn
}

output "COREDNS_ADDON_NAME" {
  value = aws_eks_addon.COREDNS.addon_name
}

output "COREDNS_ADDON_ARN" {
  value = aws_eks_addon.COREDNS.arn
}

output "KUBE_PROXY_ADDON_NAME" {
  value = aws_eks_addon.KUBE_PROXY.addon_name
}

output "KUBE_PROXY_ADDON_ARN" {
  value = aws_eks_addon.KUBE_PROXY.arn
}

# output "EBS_CSI_ADDON_NAME" {
#   value = aws_eks_addon.EBS_CSI.addon_name
# }

# output "EBS_CSI_ADDON_ARN" {
#   value = aws_eks_addon.EBS_CSI.arn
# }

