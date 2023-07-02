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
        github = {
          source = "integrations/github"
          version = "5.26.0"
        }
      }
    }
    EOF
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/github//."
}

dependency "aws" {
  config_path = "../aws"
}

inputs = {
  secrets = {
    aws_account_id = {
      repository = "xit"
      name = "AWS_ACCOUNT_ID"
      value = dependency.aws.outputs.aws_account_id
    }
    aws_github_actions_xit_role_arn = {
      repository = "xit"
      name = "AWS_GITHUB_ACTIONS_XIT_ROLE_ARN"
      value = dependency.aws.outputs.github_actions_role_arn
    }
  }
}
