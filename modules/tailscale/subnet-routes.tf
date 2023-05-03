data "tailscale_device" "these" {
  for_each = var.subnet_routes
  name     = "${each.key}.${var.tailnet_dns_name}"
}

resource "tailscale_device_subnet_routes" "these" {
  for_each = var.subnet_routes

  device_id = data.tailscale_device.these[each.key].id
  routes    = each.value
}
