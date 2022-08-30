output "arn" {
  value = aws_iam_user.main.arn
  description = "The ARN of the user."
}

output "password" {
  value = one(aws_iam_user_login_profile.main[*].password)
  description = "The password in plain text."
}

output "access_key_id" {
  value = one(aws_iam_access_key.main[*].id)
  description = "The access key ID."
}

output "secret_access_key" {
  value = one(aws_iam_access_key.main[*].secret)
  description = "The secret access key in plain text."
}

output "encrypted_password" {
  value = one(aws_iam_user_login_profile.main[*].encrypted_password)
  description = "The PGP-encrypted, base64-encoded password."
}

output "encrypted_secret_access_key" {
  value = one(aws_iam_access_key.main[*].encrypted_secret)
  description = "The PGP-encrypted, base64-encoded secret access key."
}
