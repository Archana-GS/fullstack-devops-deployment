terraform {
  backend "s3" {
    bucket         = "8byte-s3-bucket"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}