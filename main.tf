locals {
  arn_map = { for k in keys(var.map) : k => aws_ssm_parameter.secret_var[k].arn }
  ecs_secrets = [
    for k, v in local.arn_map : {
      name      = k,
      valueFrom = v,
    }
  ]
}

resource "aws_kms_key" "encryption_key" {
  description             = "This key is used to encrypt SSM '${var.ssm_key_prefix}' parameters"
  deletion_window_in_days = var.deletion_window
}

resource "aws_kms_alias" "encryption_key_alias" {
  name          = "alias/${var.ssm_key_prefix}"
  target_key_id = aws_kms_key.encryption_key.key_id
}

resource "aws_ssm_parameter" "secret_var" {
  for_each = var.map

  name      = "/${var.ssm_key_prefix}/${each.key}"
  type      = "SecureString"
  key_id    = aws_kms_key.encryption_key.arn
  value     = each.value
  tier      = var.ssm_parameter_tier
}
