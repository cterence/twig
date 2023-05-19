terragrunt_version_constraint = "~> 0.45.0"
terraform_version_constraint  = "~> 1.4.0"

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    terraform {
      backend "s3" { 
        bucket                      = "twig-tfstates"
        key                         = "${path_relative_to_include()}/terraform.tfstate"
        endpoint                    = "https://d2c3d37341116095bc4b4f533dc5c487.r2.cloudflarestorage.com"
        region                      = "us-east-1"
        skip_credentials_validation = true
      }
    }
  EOF
}
