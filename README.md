# Terraform module for injecting sensitive data as environment variables

This module can be useful if you need to inject a list of secret environment variables (like API keys, secret tokens, etc.) into
[AWS ECS task definition](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data-parameters.html#secrets-envvar-parameters).

## Usage example

```terraform
locals {
  environment = "staging"

  secret_app_env_vars = {
    AWS_ACCESS_KEY_ID     = "some_access_key"
    AWS_SECRET_ACCESS_KEY = "some_secret_access_key"
    STRIPE_SECRET_KEY     = "sk_live_xxxxxxxxxxxxxxxxxxxxxxx"
  }
}

module "secret_variables" {
  source             = "DualbootPartnersLLC/secret-variables-json/aws"
  version            = "1.0.4"
  map                = local.secret_app_env_vars
  ssm_key_prefix     = local.environment
  ssm_parameter_tier = "Advanced"
}

module "app" {
  source = "<path/to/app/module>"
  secret_env_vars = module.secret_variables.json
}

```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| map | Map of variables. | `map(string)` | n/a | yes |
| ssm_key_prefix | Prefix for SSM keys. | `string` | n/a | yes |
| ssm_parameter_tier | Tier of SSM parameters. | `string` | "Standard" | no |

## Outputs

| Name | Description |
|------|-------------|
| json | JSON representation of variables map |
