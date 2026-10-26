data "aws_eks_cluster" "EXISTING" {
  name = var.EKS_CLUSTER_NAME
}

data "tls_certificate" "EKS_OIDC" {
  url = data.aws_eks_cluster.EXISTING.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "EKS" {
  url = data.aws_eks_cluster.EXISTING.identity[0].oidc[0].issuer

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.EKS_OIDC.certificates[
      length(data.tls_certificate.EKS_OIDC.certificates) - 1
    ].sha1_fingerprint
  ]

  tags = {
    Name = "${var.EKS_CLUSTER_NAME}-oidc-provider"
  }
}