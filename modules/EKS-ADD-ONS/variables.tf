
variable "EKS_CLUSTER_NAME" {
  type = string
}

variable "EBS_CSI_ROLE_ARN" {
  type = string
}

variable "PROJECT_NAME" {
  type = string
}

variable "ENVIRONMENT" {
  type = string
}

variable "COMMON_TAGS" {
  type = map(string)
}

