variable "AWS_REGION" {
  type = string
}

variable "EKS_CLUSTER_NAME" {
  type = string
}

variable "VPC_ID" {
  type = string
}

variable "EKS_OIDC_PROVIDER_ARN" {
  type = string
}

variable "EKS_OIDC_ISSUER_URL" {
  type = string
}

variable "IAM_ROLE_NAME" {
  type = string
}

variable "HELM_CHART_VERSION" {
  type = string
}