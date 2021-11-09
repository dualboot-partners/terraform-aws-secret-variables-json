variable "map" {
  type        = map(string)
  description = "Map of variables."
}

variable "ssm_key_prefix" {
  type        = string
  description = "Prefix for SSM key"
}

variable "ssm_parameter_tier" {
  type        = string
  description = "Tier of SSM parameters"
  default     = "Standard"
}
