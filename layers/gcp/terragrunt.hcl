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
          version = "6.42.0"
        }
      }
    }
    EOF
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/gcp//."
}

inputs = {
  region         = "us-east1"
  project_id     = "nifty-structure-304711"
  project_number = "602698434371"
  subnetwork     = "default"
  num_instances  = 1
  hostname       = "gatus"
}
