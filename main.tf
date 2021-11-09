resource "aws_kms_key" "encryption_key" {
  description             = "This key is used to encrypt SSM '${var.ssm_key_prefix}' parameters"
  deletion_window_in_days = 10
}

resource "aws_ssm_parameter" "secret_var" {
  for_each = var.map

  name        = "/${var.ssm_key_prefix}/${each.key}"
  type        = "SecureString"
  overwrite   = true
  key_id      = aws_kms_key.encryption_key.arn
  value       = each.value
  tier        = var.ssm_parameter_tier
}
