
AWS_REGION = "us-east-1"

GITHUB_OWNER      = "payal-kharat"
GITHUB_REPOSITORY = "Employee_Management_Helm_EKS"
GITHUB_BRANCH     = "main"

IAM_ROLE_NAME         = "employee-mgm-github-actions-role"
ECR_REPOSITORY_PREFIX = "employee-mgm-"

EKS_CLUSTER_NAMES = [
  "employee-mgm-qa-cluster"
]

EKS_CLUSTER_NAME = "employee-mgm-qa-cluster"

KUBERNETES_NAMESPACES = [
  "dev",
  "qa",
  "uat",
  "prod"
]
