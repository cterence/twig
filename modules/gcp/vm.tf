module "instance_template" {
  source               = "terraform-google-modules/vm/google//modules/instance_template"
  version              = "12.1.2"
  region               = var.region
  project_id           = var.project_id
  subnetwork           = var.subnetwork
  subnetwork_project   = var.project_id
  service_account      = var.service_account
  machine_type         = var.machine_type
  source_image_family  = var.source_image_family
  source_image_project = var.source_image_project
  disk_size_gb         = var.disk_size_gb
}

module "compute_instance" {
  source              = "terraform-google-modules/vm/google//modules/compute_instance"
  version             = "12.1.2"
  region              = var.region
  zone                = var.zone
  subnetwork          = var.subnetwork
  subnetwork_project  = var.project_id
  num_instances       = var.num_instances
  hostname            = var.hostname
  instance_template   = module.instance_template.self_link
  deletion_protection = false

  access_config = [{
    nat_ip       = var.nat_ip
    network_tier = var.network_tier
  }, ]
}
