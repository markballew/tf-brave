module "tfstate_backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "0.38.1"

  force_destroy                 = var.force_destroy
  prevent_unencrypted_uploads   = var.prevent_unencrypted_uploads
  enable_server_side_encryption = var.enable_server_side_encryption
  terraform_backend_config_file_path = var.terraform_backend_config_file_path
  terraform_backend_config_file_name = var.terraform_backend_config_file_name

  context = module.this.context
}
