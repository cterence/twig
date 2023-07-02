data "github_actions_public_key" "these" {
  for_each = var.secrets

  repository = each.value.repository
}

resource "github_actions_secret" "these" {
  for_each = var.secrets

  repository       = each.value.repository
  secret_name      = each.value.name
  plaintext_value  = each.value.value
}
