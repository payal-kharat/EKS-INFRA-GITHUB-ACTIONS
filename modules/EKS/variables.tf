variable "AWS_REGION" {
  type = string
}

variable "PROJECT_NAME" {
  type = string
}

variable "EKS_CLUSTER_NAME" {
  type = string
}

variable "EKS_CLUSTER_VERSION" {
  type = string
}

variable "CONTROL_PLANE_SUBNET_IDS" {
  type = list(string)
}

variable "PRIVATE_SUBNET_IDS" {
  type = list(string)
}

variable "NODE_INSTANCE_TYPE" {
  type    = string
  default = "t3.small"
}

variable "NODE_DESIRED_SIZE" {
  type    = number
  default = 2
}

variable "NODE_MIN_SIZE" {
  type    = number
  default = 1
}

variable "NODE_MAX_SIZE" {
  type    = number
  default = 3
}

variable "EBS_CSI_IAM_ROLE_NAME" {
  type = string
}