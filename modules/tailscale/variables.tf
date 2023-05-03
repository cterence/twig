variable "acl" {
  type = object({
    acls = list(object({
      action = string
      src    = list(string)
      dst    = list(string)
    }))
    ssh = list(object({
      action = string
      src    = list(string)
      dst    = list(string)
      users  = list(string)
    }))
    autoapprovers = object({
      routes   = map(list(string))
      exitnode = optional(list(string))
    })
  })
}

variable "search_paths" {
  type    = list(string)
  default = []
}

variable "subnet_routes" {
  type    = map(list(string))
  default = {}
}

variable "tailnet_dns_name" {
  type    = string
  default = ""
}
