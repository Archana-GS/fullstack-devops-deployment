variable "region" {
  default = "ap-south-1"
}

variable "ami" {
  default = "ami-0f58b397bc5c1f2e8"
}

variable "instance_type" {
  default = "t3.small"
}

variable "ecr_repo_url" {}

variable "db_password" {
  sensitive = true
}