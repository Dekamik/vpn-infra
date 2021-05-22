terraform {
  required_providers {
    linode = {
        source = "linode/linode"
        version = "1.16.0"
    }
  }
}

provider "linode" {
    token = var.token
}

resource "linode_instance" "vpn-us-se" {
  label = "vpn-us-se"
  image = "linode/ubuntu20.04"
  region = "us-southeast"
  type = "g6-standard-1"
  authorized_keys = [var.ssh_key]
  root_pass = var.root_pass

  connection {
    type = "ssh"
    user = "root"
    password = var.root_pass
    host = self.ip_address
  }

  provisioner "file" {
      source = ""
      destination = "/tmp/"
  }
}
