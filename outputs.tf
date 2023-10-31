output "json" {
  description = "JSON representation of variables map."
  sensitive   = false

  value = join(",",
    [for i in local.ecs_secrets :
      jsonencode(i)
    ]
  )
}

output "arn_map" {
  sensitive = false
  value     = local.arn_map
}

output "ecs_secrets" {
  sensitive = false
  value     = local.ecs_secrets
}
