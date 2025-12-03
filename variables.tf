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

variable "deletion_window" {
  description = "Deletion window in days"
  type        = number
  default     = 10
}

variable "create_kms_alias" {
  description = "Flag for creating KMS Key Alias"
  type        = bool
  default     = false
}

variable "enable_key_rotation" {
  description = "Enable automatic rotation of the KMS key"
  type        = bool
  default     = false
}
