terraform {
  required_version = ">= 0.12.2"

  backend "s3" {
    region         = "us-west-2"
    bucket         = "mb-uw2-dev1"
    key            = "ec2/terraform.tfstate"
    dynamodb_table = "mb-uw2-dev1-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"
  }
}