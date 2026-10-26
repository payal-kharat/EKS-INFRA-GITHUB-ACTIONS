variable "AWS_REGION" {
  description = "AWS region for ECR repositories"
  type        = string
}

variable "ECR_REPOSITORY_NAMES" {
  description = "List of ECR repository names"
  type        = list(string)
}

variable "IMAGE_TAG_MUTABILITY" {
  description = "Whether image tags can be overwritten"
  type        = string
  default     = "MUTABLE"
  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.IMAGE_TAG_MUTABILITY)
    error_message = "IMAGE_TAG_MUTABILITY must be MUTABLE or IMMUTABLE."
  }
}