terraform {
  required_version = ">= 0.12.2"

  backend "s3" {
    region         = "us-west-2"
    bucket         = "mb-uw2-dev"
    key            = "terraform.tfstate"
    dynamodb_table = "mb-uw2-dev-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"
  }
}
