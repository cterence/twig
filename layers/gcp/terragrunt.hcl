include "root" {
  path           = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    terraform {
      required_providers {
        google = {
          source = "hashicorp/google"
          version = "4.65.2"
        }
      }
    }
    EOF
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/gcp//."
}

dependency "secrets" {
  config_path = "../secrets"
}

inputs = {
  region        = "us-east1"
  project_id    = dependency.secrets.outputs.secrets.gcp_project_id
  subnetwork    = "default"
  num_instances = 1
  hostname      = "frontline"
}
