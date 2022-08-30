# Terraform modules for AWS IAM

Make it easier to handle users and permissions in AWS.


## Available modules

### //modules/user

An IAM user.

Can be a web console user or CLI only, or both.

```hcl
module "aws_system_users" {
  source = "d7oss/terraform-aws-iam//user"
  version = "~> 1.0"  # >= 1.0.0, < 2.0.0

  for_each = toset([
    "terraformcloud",
    "cicd",
  ])

  name = each.key
  enable_console = false
  enable_cli = true

  allow = {
    "admin" = {
      actions = ["*"]
      resources = ["*"]
    }
  }
}
```

```hcl
module "aws_console_users" {
  source = "d7oss/terraform-aws-iam//user"
  version = "~> 1.0"  # >= 1.0.0, < 2.0.0

  for_each = {
    "carol.silva": "keybase:carolsilva",
    "john.doe": "keybase:johndoe",
  }

  name = each.key
  pgp_key = each.value
  enable_console = true
  enable_cli = true

  allow = {
    "admin" = {
      actions = ["*"]
      resources = ["*"]
    }
  }

  deny_policies = {
    ...
  }
}
```
