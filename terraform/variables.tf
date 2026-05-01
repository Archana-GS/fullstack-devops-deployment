# Variables file for Terraform

# This file defines configurable inputs such as:
# - AMI ID
# - Instance type
# - AWS region
# - ECR repository URL

# Helps avoid hardcoding values and improves reusability

variable "region" {
  default = "ap-south-1"
}

variable "ami" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  default = "t3.small"
}

variable "ecr_repo_url" {}

variable "db_password" {
  sensitive = true
}

variable "db_username" {
  default = "postgres"
}

