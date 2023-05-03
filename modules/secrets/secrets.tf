data "gitlab_project_variable" "these" {
  for_each = toset(var.secrets)
  project  = var.secrets_project
  key      = each.value
}
