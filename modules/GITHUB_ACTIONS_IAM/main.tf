


# resource "aws_iam_openid_connect_provider" "GITHUB" {
#   url = "https://token.actions.githubusercontent.com"

#   client_id_list = [
#     "sts.amazonaws.com"
#   ]
# }

# data "aws_iam_openid_connect_provider" "GITHUB" {
#   url = "https://token.actions.githubusercontent.com"
# }


data "aws_caller_identity" "CURRENT" {}

data "aws_iam_role" "GITHUB_ACTIONS" {
  name = "GitHubActions-EKS-Terraform-Role"
}

resource "aws_iam_policy" "ECR_ACCESS" {
  name        = "employee-mgm-github-actions-ecr-policy"
  description = "Allow GitHub Actions to push and pull Employee Management images"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "ECRAuthentication"
        Effect   = "Allow"
        Action   = ["ecr:GetAuthorizationToken"]
        Resource = "*"
      },
      {
        Sid    = "ECRRepositoryAccess"
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeImages",
          "ecr:DescribeRepositories",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:ListImages",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
        Resource = [
          "arn:aws:ecr:${var.AWS_REGION}:${data.aws_caller_identity.CURRENT.account_id}:repository/${var.ECR_REPOSITORY_PREFIX}*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "EKS_DESCRIBE" {
  name        = "employee-mgm-github-actions-eks-describe-policy"
  description = "Allow GitHub Actions to retrieve existing EKS cluster details"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:DescribeCluster"
        ]
        Resource = [
          for CLUSTER in var.EKS_CLUSTER_NAMES :
          "arn:aws:eks:${var.AWS_REGION}:${data.aws_caller_identity.CURRENT.account_id}:cluster/${CLUSTER}"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy" "ECR_REPOSITORY_MANAGEMENT" {
  name = "Terraform-ECR-Repository-Management"
  role = data.aws_iam_role.GITHUB_ACTIONS.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ManageEmployeeManagementECR"
        Effect = "Allow"
        Action = [
          "ecr:CreateRepository",
          "ecr:DescribeRepositories",
          "ecr:ListTagsForResource",
          "ecr:TagResource",
          "ecr:UntagResource",
          "ecr:PutLifecyclePolicy",
          "ecr:GetLifecyclePolicy",
          "ecr:DeleteLifecyclePolicy",
          "ecr:PutImageScanningConfiguration",
          "ecr:PutImageTagMutability"
        ]
        Resource = "arn:aws:ecr:${var.AWS_REGION}:${data.aws_caller_identity.CURRENT.account_id}:repository/${var.ECR_REPOSITORY_PREFIX}*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "EKS_ADDON_MANAGEMENT" {
  name = "Terraform-EKS-Addon-Management"
  role = data.aws_iam_role.GITHUB_ACTIONS.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ManageEmployeeManagementEKSAddons"
        Effect = "Allow"
        Action = [
          "eks:CreateAddon",
          "eks:DescribeAddon",
          "eks:DescribeAddons",
          "eks:ListAddons",
          "eks:UpdateAddon",
          "eks:DeleteAddon"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ECR_ACCESS" {
  role       = data.aws_iam_role.GITHUB_ACTIONS.name
  policy_arn = aws_iam_policy.ECR_ACCESS.arn
}

resource "aws_iam_role_policy_attachment" "EKS_DESCRIBE" {
  role       = data.aws_iam_role.GITHUB_ACTIONS.name
  policy_arn = aws_iam_policy.EKS_DESCRIBE.arn
}
