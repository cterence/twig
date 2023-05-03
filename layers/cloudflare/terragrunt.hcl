include "root" {
  path           = find_in_parent_folders()
  merge_strategy = "deep"
}

generate "provider" {
  path      = "_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}
EOF
}

terraform {
  source = "${get_repo_root()}/modules/cloudflare//."
}

dependency "secrets" {
  config_path = "../secrets"
}

inputs = {
  account_id =  dependency.secrets.outputs.secrets.cloudflare_account_id
  tunnels = {
    "Homelab" =  dependency.secrets.outputs.secrets.cloudflare_tunnel_secret
  }
}
