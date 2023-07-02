variable "account_id" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "tunnels" {
  type = map(object({
    secret = string
    ingress_rules = optional(map(object({
      hostname = optional(string)
      path     = optional(string)
      service  = string
    })), {})
  }))
}
