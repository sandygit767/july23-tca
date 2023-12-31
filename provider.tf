provider "aws" {
  region = var.region
}
terraform {
  backend "s3" {
    bucket         = "jhc-tca-state12"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tca"
  }
}