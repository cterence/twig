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
    tailscale = {
      source = "tailscale/tailscale"
      version = "~> 0.13.0"
    }
  }
}
EOF
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/tailscale//."
}

dependency "secrets" {
  config_path = "../secrets"
}

inputs = {
  subnet_routes =  {}

  acl = {
    acls = [{
      action = "accept",
      src    = ["*"],
      dst    = ["*:*"]
    }]

    ssh = [
      // Allow all users to SSH into their own devices in check mode.
      // Comment this section out if you want to define specific restrictions.
      {
        action = "check",
        src    = ["autogroup:members"],
        dst    = ["autogroup:self"],
        users  = ["autogroup:nonroot", "root"],
      }
    ]

    autoapprovers = {
      routes = {
        "10.244.0.0/24" = ["autogroup:members"]
        "10.96.0.0/12"  = ["autogroup:members"]
      }
    }

    tagowners = {
      "tag:k8s" = [
        "tag:k8s-operator"
      ]
      "tag:k8s-operator" = []
    }
  }

  search_paths = []

  tailnet_dns_name = dependency.secrets.outputs.secrets.tailnet_dns_name
}
