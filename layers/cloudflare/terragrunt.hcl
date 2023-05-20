include "root" {
  path           = find_in_parent_folders()
  merge_strategy = "deep"
}

generate "provider" {
  path      = "_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    terraform {
      required_providers {
        cloudflare = {
          source  = "cloudflare/cloudflare"
          version = "4.6.0"
        }

        aws = {
          source = "hashicorp/aws"
          version = "4.20.1"
        }
      }
    }

    provider "aws" {
      skip_credentials_validation = true
      skip_region_validation = true
      skip_requesting_account_id = true
      region = "weur"
      endpoints {
        s3 = "https://d2c3d37341116095bc4b4f533dc5c487.r2.cloudflarestorage.com"
      }
    }
    EOF
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/cloudflare//."
}

dependency "secrets" {
  config_path = "../secrets"
}

inputs = {
  account_id = dependency.secrets.outputs.secrets.cloudflare_account_id
  tunnels = {
    "Homelab" = dependency.secrets.outputs.secrets.cloudflare_tunnel_secret
  }
  bucket_name = "twig-tfstates"
}
