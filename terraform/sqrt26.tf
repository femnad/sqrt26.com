variable dns_name {}
variable dns_root {}
variable managed_zone {}
variable project {}
variable service_account_file {}
variable ssh_user {}

module "instance-module" {
  source  = "femnad/instance-module/gcp"
  version = "0.2.2"
  github_user = "femnad"
  prefix = "sqrt26"
  project = var.project
  service_account_file = var.service_account_file
  ssh_user = var.ssh_user
}

module "dns-module" {
  source  = "femnad/dns-module/gcp"
  version = "0.1.3"
  dns_name = var.dns_name
  dns_root = var.dns_root
  instance_ip_addr = module.instance-module.instance_ip_addr
  managed_zone = var.managed_zone
  project = var.project
  service_account_file = var.service_account_file
}
