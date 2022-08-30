resource "aws_iam_user" "main" {
  /*
  The user
  */
  name = var.name
  path = var.path
  force_destroy = true
}

resource "aws_iam_user_login_profile" "main" {
  /*
  A login profile for accessing the web console
  */
  count = var.enable_console ? 1 : 0
  user = aws_iam_user.main.name
  pgp_key = var.pgp_key
  password_reset_required = false  # We trust PGP, but the user can change it
}

resource "aws_iam_access_key" "main" {
  /*
  An access key for accessing the CLI
  */
  count = var.enable_cli ? 1 : 0
  user = aws_iam_user.main.name
  pgp_key = var.pgp_key
}

resource "aws_iam_user_policy" "allow" {
  /*
  Policy statements for allowed actions
  */
  for_each = var.allow

  user = aws_iam_user.main.name
  name = each.key
  policy = data.aws_iam_policy_document.allow[each.key].json
}

data "aws_iam_policy_document" "allow" {
  /*
  Policy documents for allowed actions
  */
  for_each = var.allow

  statement {
    effect = "Allow"
    actions = each.value.actions
    resources = each.value.resources
  }
}

resource "aws_iam_user_policy" "deny" {
  /*
  Policy statements for denied actions
  */
  for_each = var.deny

  user = aws_iam_user.main.id
  name = each.key
  policy = data.aws_iam_policy_document.deny[each.key].json
}

data "aws_iam_policy_document" "deny" {
  /*
  Policy documents for denied actions
  */
  for_each = var.deny

  statement {
    effect = "Deny"
    actions = each.value.actions
    resources = each.value.resources
  }
}
