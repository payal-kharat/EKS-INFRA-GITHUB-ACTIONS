data "tls_certificate" "EKS_OIDC" {
  url = aws_eks_cluster.EKS.identity[0].oidc[0].issuer
}

locals {
  OIDC_ISSUER = replace(aws_eks_cluster.EKS.identity[0].oidc[0].issuer, "https://", "")
}

resource "aws_iam_role" "EKS_CLUSTER" {
  name = "${var.EKS_CLUSTER_NAME}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "EKS_CLUSTER" {
  role       = aws_iam_role.EKS_CLUSTER.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "EKS_NODE" {
  name = "${var.EKS_CLUSTER_NAME}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "EKS_NODE" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  ])

  role       = aws_iam_role.EKS_NODE.name
  policy_arn = each.value
}

resource "aws_eks_cluster" "EKS" {
  name     = var.EKS_CLUSTER_NAME
  role_arn = aws_iam_role.EKS_CLUSTER.arn
  version  = var.EKS_CLUSTER_VERSION

  vpc_config {
    subnet_ids              = var.CONTROL_PLANE_SUBNET_IDS
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.EKS_CLUSTER
  ]
}

resource "aws_eks_node_group" "EKS" {
  cluster_name    = aws_eks_cluster.EKS.name
  node_group_name = "${var.EKS_CLUSTER_NAME}-nodes"
  node_role_arn   = aws_iam_role.EKS_NODE.arn
  subnet_ids      = var.PRIVATE_SUBNET_IDS
  instance_types  = [var.NODE_INSTANCE_TYPE]

  scaling_config {
    desired_size = var.NODE_DESIRED_SIZE
    min_size     = var.NODE_MIN_SIZE
    max_size     = var.NODE_MAX_SIZE
  }

  depends_on = [
    aws_iam_role_policy_attachment.EKS_NODE
  ]
}

resource "aws_iam_openid_connect_provider" "EKS" {
  url = aws_eks_cluster.EKS.identity[0].oidc[0].issuer

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.EKS_OIDC.certificates[
      length(data.tls_certificate.EKS_OIDC.certificates) - 1
    ].sha1_fingerprint
  ]
}

resource "aws_iam_role" "EBS_CSI" {
  name = var.EBS_CSI_IAM_ROLE_NAME

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = aws_iam_openid_connect_provider.EKS.arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${local.OIDC_ISSUER}:aud" = "sts.amazonaws.com"
          "${local.OIDC_ISSUER}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "EBS_CSI" {
  role       = aws_iam_role.EBS_CSI.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_eks_addon" "EBS_CSI" {
  cluster_name             = aws_eks_cluster.EKS.name
  addon_name               = "aws-ebs-csi-driver"
  service_account_role_arn = aws_iam_role.EBS_CSI.arn

  depends_on = [
    aws_eks_node_group.EKS,
    aws_iam_role_policy_attachment.EBS_CSI
  ]
}