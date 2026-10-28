
AWS_REGION = "us-east-1"

PROJECT_NAME         = "employee-mgm"
VPC_CIDR             = "10.0.0.0/16"
AVAILABILITY_ZONES   = ["us-east-1a", "us-east-1b"]
PUBLIC_SUBNET_CIDRS  = ["10.0.1.0/24", "10.0.2.0/24"]
PRIVATE_SUBNET_CIDRS = ["10.0.11.0/24", "10.0.12.0/24"]
ENABLE_NAT_GATEWAY   = true


GITHUB_OWNER      = "payal-kharat"
GITHUB_REPOSITORY = "Employee_Management_Helm_GithubActions_EKS"
GITHUB_BRANCH     = "main"

# IAM_ROLE_NAME         = "employee-mgm-github-actions-role"
IAM_ROLE_ARN          = "arn:aws:iam::020048087135:role/GitHubActions-Employee-DB-Role"
ECR_REPOSITORY_PREFIX = "employee-mgm-"

EKS_CLUSTER_NAMES = [
  "employee-mgm-dev-cluster"
]

EKS_CLUSTER_NAME      = "employee-mgm-dev-cluster"
EKS_CLUSTER_VERSION   = "1.33"
NODE_INSTANCE_TYPE    = "t2.medium"
NODE_DESIRED_SIZE     = 1
NODE_MIN_SIZE         = 1
NODE_MAX_SIZE         = 1
EBS_CSI_IAM_ROLE_NAME = "employee-mgm-dev-ebs-csi-role"

KUBERNETES_NAMESPACES = [
  "dev",
  "qa",
  "uat",
  "prod"
]

ECR_REPOSITORY_NAMES = [
  "employee-mgm-dev-db",
  "employee-mgm-dev-backend",
  "employee-mgm-dev-frontend"
]

IMAGE_TAG_MUTABILITY = "MUTABLE"

LOAD_BALANCER_CONTROLLER_IAM_ROLE_NAME = "employee-mgm-dev-load-balancer-controller-role"
HELM_CHART_VERSION                     = "1.14.0"
