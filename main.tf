resource "aws_ssm_parameter" "secret_var" {
  for_each = var.map

  name        = "/${var.ssm_key_prefix}/${each.key}"
  type        = "SecureString"
  value       = each.value
}
