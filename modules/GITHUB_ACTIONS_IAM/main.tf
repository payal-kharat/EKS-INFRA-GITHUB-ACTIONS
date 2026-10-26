
data "aws_caller_identity" "CURRENT" {}

resource "aws_iam_openid_connect_provider" "GITHUB" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]
}

resource "aws_iam_role" "GITHUB_ACTIONS" {
  name = var.IAM_ROLE_NAME

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Federated = aws_iam_openid_connect_provider.GITHUB.arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }

          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:${var.GITHUB_OWNER}/${var.GITHUB_REPOSITORY}:ref:refs/heads/${var.GITHUB_BRANCH}"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "ECR_ACCESS" {
  name        = "${var.IAM_ROLE_NAME}-ecr-policy"
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
  name        = "${var.IAM_ROLE_NAME}-eks-describe-policy"
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
  role = aws_iam_role.GITHUB_ACTIONS_TERRAFORM.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ManageEmployeeManagementECR"
        Effect = "Allow"
        Action = [
          "ecr:CreateRepository",
          "ecr:DescribeRepositories",
          "ecr:TagResource",
          "ecr:UntagResource",
          "ecr:PutLifecyclePolicy",
          "ecr:GetLifecyclePolicy",
          "ecr:DeleteLifecyclePolicy",
          "ecr:PutImageScanningConfiguration",
          "ecr:PutImageTagMutability"
        ]
        Resource = "arn:aws:ecr:us-east-1:552940445807:repository/employee-mgm-dev-*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "EKS_ADDON_MANAGEMENT" {
  name = "Terraform-EKS-Addon-Management"
  role = aws_iam_role.GITHUB_ACTIONS_TERRAFORM.id

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
  role       = aws_iam_role.GITHUB_ACTIONS.name
  policy_arn = aws_iam_policy.ECR_ACCESS.arn
}

resource "aws_iam_role_policy_attachment" "EKS_DESCRIBE" {
  role       = aws_iam_role.GITHUB_ACTIONS.name
  policy_arn = aws_iam_policy.EKS_DESCRIBE.arn
}
