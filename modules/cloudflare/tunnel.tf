resource "cloudflare_tunnel" "these" {
  for_each = var.tunnels

  account_id = var.account_id
  name       = each.key
  secret     = each.value
}
