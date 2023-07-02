variable "secrets" {
  type = map(object({
    repository = string
    name       = string
    value      = string
  }))
  description = "Secrets to create in GitHub Actions"
}
