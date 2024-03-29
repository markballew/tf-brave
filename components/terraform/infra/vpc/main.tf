
module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "1.1.0"

  cidr_block = var.cidr_block

  context = module.this.context
}

module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "1.0.0"

  availability_zones              = var.availability_zones
  cidr_block                      = module.vpc.vpc_cidr_block
  igw_id                          = module.vpc.igw_id
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  max_subnet_count                = var.max_subnet_count
  nat_gateway_enabled             = var.nat_gateway_enabled
  nat_instance_enabled            = var.nat_instance_enabled
  nat_instance_type               = var.nat_instance_type
  subnet_type_tag_key             = var.subnet_type_tag_key
  subnet_type_tag_value_format    = var.subnet_type_tag_value_format
  vpc_id                          = module.vpc.vpc_id

  context = module.this.context
}
