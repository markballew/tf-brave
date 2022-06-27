variable "region" {
  type        = string
  description = "AWS region"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to SSH public key directory (e.g. `/secrets`)"
}

variable "generate_ssh_key" {
  type        = bool
  description = "If set to `true`, new SSH key pair will be created"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with the instance"
}

variable "assign_eip_address" {
  type        = bool
  description = "Assign an Elastic IP address to the instance"
}

variable "instance_type" {
  type        = string
  description = "The type of the instance"
}

variable "ami_owner" {
  type        = string
  description = "Owner of the given AMI"
}

variable "root_volume_size" {
  type        = number
  description = "Size of the root volume in gigabytes"
}