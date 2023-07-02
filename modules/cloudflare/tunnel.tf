resource "cloudflare_tunnel" "these" {
  for_each = var.tunnels

  account_id = var.account_id
  name       = each.key
  secret     = each.value.secret
}

resource "cloudflare_tunnel_config" "these" {
  for_each = var.tunnels

  account_id = var.account_id
  tunnel_id  = cloudflare_tunnel.these[each.key].id
  config {
    dynamic "ingress_rule" {
      for_each = each.value.ingress_rules
      content {
        hostname = lookup(ingress_rule.value, "hostname", null)
        path     = lookup(ingress_rule.value, "path", null)
        service  = lookup(ingress_rule.value, "service", null)
      }
    }
  }
}
