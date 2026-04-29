provider "aws" {
  region = var.region
}


resource "aws_s3_bucket" "s3_bucket" {
  bucket = "terraform-0owk-bucket"
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


module "vpc" {
  source = "./modules/vpc"

  vpc_cidr        = var.vpc_cidr
  public_subnet   = var.public_subnet
  private_subnet  = var.private_subnet
  az_public       = var.az_public
  az_private      = var.az_private
}