output "secrets" {
  value = {
    for secret in var.secrets :
    secret => data.gitlab_project_variable.these[secret].value
  }
  sensitive = true
}
