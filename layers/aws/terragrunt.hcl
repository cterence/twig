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
        aws = {
          source  = "hashicorp/aws"
          version = "5.2.0"        
        }
      }
    }

    provider "aws" {
      region  = "${local.region}"
      profile = "twig"

      default_tags {
        tags = {
          "ManagedBy"  = "Terraform"
          "Repository" = "cterence/twig"
        }
      }
    }
    EOF
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/aws//."
}

dependency "secrets" {
  config_path = "../secrets"
}

locals {
  region = "eu-west-3"
}

inputs = {
}
