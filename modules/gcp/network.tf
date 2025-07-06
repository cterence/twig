module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  version      = "11.1.1"
  project_id   = var.project_id
  network_name = "default"

  rules = [{
    name                    = "allow-http-https-traffic"
    description             = null
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["109.0.228.97/32"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = null
    target_service_accounts = null
    allow = [
      {
        protocol = "tcp"
        ports    = ["22", "80", "443"]
      }
    ]
    deny = []
  }]
}
