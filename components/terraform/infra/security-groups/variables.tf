variable "region" {
  type = string
}

variable "inline_rules_enabled" {
  type        = bool
  description = "Flag to enable/disable inline security group rules"
  default     = false
}