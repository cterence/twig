variable "project_id" {
  description = "The GCP project to use for integration tests"
  type        = string
}

variable "region" {
  description = "The GCP region to create and test resources in"
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "The GCP zone to create resources in"
  type        = string
  default     = null
}

variable "subnetwork" {
  description = "The subnetwork selflink to host the compute instances in"
}

variable "num_instances" {
  description = "Number of instances to create"
}

variable "hostname" {
  description = "Hostname to assign to the instance"
  type        = string
}

variable "nat_ip" {
  description = "Public ip address"
  default     = null
}

variable "network_tier" {
  description = "Network network_tier"
  default     = "PREMIUM"
}

variable "service_account" {
  default = null
  type = object({
    email  = string,
    scopes = set(string)
  })
  description = "Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template#service_account."
}

variable "machine_type" {
  description = "Machine type to create, e.g. n1-standard-1"
  type        = string
  default     = "e2-micro"
}

variable "source_image_family" {
  type    = string
  default = "debian-12"
}

variable "source_image_project" {
  type    = string
  default = "debian-cloud"
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  type        = string
  default     = "30"
}

variable "disk_type" {
  description = "Boot disk type, e.g. pd-standard or pd-ssd"
  type        = string
  default     = "pd-standard"
}
