terraform {
  backend "s3" {
    bucket         = "terraform-0owk-bucket"
    key            = "3-tier-application/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}