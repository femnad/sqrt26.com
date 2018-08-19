variable "do_token" {}
variable "current_ip" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "sqrt26-droplet" {
  image = "ubuntu-18-04-x64"
  name = "iridium"
  region = "lon1"
  size = "s-1vcpu-1gb"
  ssh_keys = [12557229]
}

resource "digitalocean_firewall" "sqrt26-firewall" {
  name = "ssh-restricted"

  droplet_ids = ["${digitalocean_droplet.sqrt26-droplet.id}"]

  inbound_rule = [
    {
      protocol = "tcp"
      port_range = "22"
      source_addresses = ["${var.current_ip}"]
    },
    {
      protocol = "tcp"
      port_range = "80"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol = "tcp"
      port_range = "443"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]

  outbound_rule = [
    {
      protocol = "tcp"
      port_range = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol = "udp"
      port_range = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol = "icmp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
}
