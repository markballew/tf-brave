provider "aws" {
  region = var.region
}

data "terraform_remote_state" "ec2" {
  backend = "s3"
  config  = {
    bucket = "mb-uw2-dev1"
    key    = "env:/mb-uw2-dev1/ec2/terraform.tfstate"
    region = var.region
  }
}

module "ansible_provisioner" {
  source = "github.com/cloudposse/terraform-null-ansible"

  arguments = ["-vvvv -u ubuntu --private-key ${var.private_key_path}"]
  envs      = ["host=${data.terraform_remote_state.ec2.outputs.public_ip}"]
  playbook  = "../../../../ansible/playbooks/playbook.yml"
  dry_run   = false
}

