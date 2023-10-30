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
  version            = "2.0.0"
  map                = local.secret_app_env_vars
  ssm_key_prefix     = local.environment
  ssm_parameter_tier = "Advanced"
}

module "app" {
  source = "<path/to/app/module>"
  secret_env_vars = module.secret_variables.ecs_secrets
}

```

## Requirements

| Name      | Version |
|-----------|---------|
| terraform | \>= 1.1 |
| aws       | \>= 5.0 |

## Inputs

| Name               | Description                     | Type          | Default    | Required |
|--------------------|---------------------------------|---------------|------------|:--------:|
| map                | Map of variables.               | `map(string)` | n/a        |   yes    |
| ssm_key_prefix     | Prefix for SSM keys.            | `string`      | n/a        |   yes    |
| ssm_parameter_tier | Tier of SSM parameters.         | `string`      | `Standard` |    no    |
| deletion_window    | Deletion window in days         | `number`      | `10`       |    no    |
| create_kms_alias   | Flag for creating KMS Key Alias | `bool`        | `false`    |    no    |

## Outputs

| Name        | Description                                  |
|-------------|----------------------------------------------|
| json        | JSON representation of variables map for ECS |
| arn_map     | Map {Secret name => Parameter ARN}           |
| ecs_secrets | Pure-HCL version on `json` output            |
