provider "aws" {
  region = var.region
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = {
    bucket = "mb-uw2-dev1"
    key    = "env:/mb-uw2-dev1/vpc/terraform.tfstate"
    region = var.region
  }
}


module "server_node_sg" {
  source = "cloudposse/security-group/aws"
  version = "1.0.1"

  attributes = ["build"]
  allow_all_egress     = true
  inline_rules_enabled = var.inline_rules_enabled

  rules = [
    {
      key         = "ssh"
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null
      description = "Allow SSH from anywhere"
    }
    ]

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  security_group_create_timeout = "5m"
  security_group_delete_timeout = "2m"

  context = module.this.context
}
