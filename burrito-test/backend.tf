terraform {
  cloud {
    organization = "terencec"

    workspaces {
      name = "burrito-test"
    }
  }
}
