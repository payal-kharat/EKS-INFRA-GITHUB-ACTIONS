variable "AWS_REGION" {
  type = string
}

variable "PROJECT_NAME" {
  type = string
}

variable "VPC_CIDR" {
  type = string
}

variable "AVAILABILITY_ZONES" {
  type = list(string)
}

variable "PUBLIC_SUBNET_CIDRS" {
  type = list(string)
}

variable "PRIVATE_SUBNET_CIDRS" {
  type = list(string)
}

variable "EKS_CLUSTER_NAME" {
  type = string
}

variable "ENABLE_NAT_GATEWAY" {
  type = bool
}