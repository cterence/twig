include "root" {
  path           = find_in_parent_folders()
  merge_strategy = "deep"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "~> 15.0"
    }
  }
}
EOF
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/secrets//."
}

inputs = {
  secrets = [
    "cloudflare_tunnel_secret",
    "cloudflare_account_id",
    "tailnet_dns_name"
  ]
}
