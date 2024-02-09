include "root" {
  path           = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

terraform {
  source = "${get_parent_terragrunt_dir()}/../modules/random-pets//."
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
