variable dns_name {}
variable mapped_domain {}
variable managed_zone {}
variable project {}
variable service_account_file {}
variable verification_text {}

variable cloud_run_location {
  default = "europe-west1"
}

variable region {
  default = "europe-west-2"
}

variable zone {
  default = "europe-west2-c"
}

variable cloud_run_ipv4_addrs {
  default = ["216.239.32.21", "216.239.34.21", "216.239.36.21", "216.239.38.21"]
}

variable tag {
  default = "latest"
}
