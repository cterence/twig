output "github_actions_role_arn" {
  value = module.github_oidc_configuration.role.arn
}

# Extract the AWS account ID from the role ARN
output "aws_account_id" {
  value = regex("arn:aws:iam::(.*):.+", module.github_oidc_configuration.role.arn)[0]
}
