terraform {
  backend "s3" {
    bucket                      = "twig-tfstates"
    key                         = "burrito-test"
    endpoint                    = "https://d2c3d37341116095bc4b4f533dc5c487.r2.cloudflarestorage.com"
    region                      = "us-east-1"
    skip_credentials_validation = true
  }
}
