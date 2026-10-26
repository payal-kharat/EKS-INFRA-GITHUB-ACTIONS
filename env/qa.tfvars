
AWS_REGION = "us-east-1"


PROJECT_NAME = "employee-mgm"
VPC_CIDR = "10.0.0.0/16"
AVAILABILITY_ZONES = ["us-east-1a", "us-east-1b"]
PUBLIC_SUBNET_CIDRS = ["10.0.1.0/24", "10.0.2.0/24"]
PRIVATE_SUBNET_CIDRS = ["10.0.11.0/24", "10.0.12.0/24"]
ENABLE_NAT_GATEWAY = true

GITHUB_OWNER      = "payal-kharat"
GITHUB_REPOSITORY = "Employee_Management_Helm_GithubActions_EKS"
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

ECR_REPOSITORY_NAMES = [
  "employee-mgm-qa-db",
  "employee-mgm-qa-backend",
  "employee-mgm-qa-frontend"
]

IMAGE_TAG_MUTABILITY = "MUTABLE"
