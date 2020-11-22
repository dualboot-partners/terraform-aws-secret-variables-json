variable "map" {
  type        = map(string)
  description = "Map of variables."
}

variable "ssm_key_prefix" {
  type        = string
  description = "Prefix for SSM key"
}
