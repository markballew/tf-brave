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

data "terraform_remote_state" "security-groups" {
  backend = "s3"
  config  = {
    bucket = "mb-uw2-dev1"
    key    = "env:/mb-uw2-dev1/security-groups/terraform.tfstate"
    region = var.region
  }
}

module "aws_key_pair" {
  source              = "cloudposse/key-pair/aws"
  version             = "0.18.3"
  namespace           = module.this.namespace
  stage               = module.this.stage
  name                = "brave-build"
  attributes          = module.this.attributes
  ssh_public_key_path = var.ssh_public_key_path
  generate_ssh_key    = true
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [var.ami_owner]
}


module "ec2_instance" {
  source = "cloudposse/ec2-instance/aws"
  version = "0.43.0"

  ssh_key_pair                = module.aws_key_pair.key_name
  instance_type               = var.instance_type
  ami                         = data.aws_ami.ubuntu.id
  ami_owner                   = var.ami_owner
  vpc_id                      = data.terraform_remote_state.vpc.outputs.vpc_id
  security_groups             = [data.terraform_remote_state.security-groups.outputs.server_node_sg_id]
  subnet                      = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  associate_public_ip_address = var.associate_public_ip_address
  root_volume_size            = var.root_volume_size
  name                        = "brave-build"
  namespace                   = module.this.namespace
  stage                       = module.this.stage

  context = module.this.context
}