resource "tailscale_acl" "this" {
  acl = jsonencode(var.acl)
}
