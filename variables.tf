# variables.tf
variable "aws_region" {
  description = "AWS region for resource deployment"
  type        = string
  default     = "us-east-1" # You can change this to your preferred region
}