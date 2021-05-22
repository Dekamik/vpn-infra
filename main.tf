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
    image = "linode/ubuntu20.04lts"
    region = "us-southeast"
    type = "g6-nanode-1"
    authorized_keys = [var.ideapad_key, var.legion_key]
    root_pass = var.root_pass

    provisioner "remote-exec" {
        inline = ["sudo apt update", "sudo apt install python3 -y"]

        connection {
            host = self.ip_address
            type = "ssh"
            user = "root"
            private_key = file(var.pvt_key)
        }
    }

    provisioner "local-exec" {
        command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ip_address}' --private-key ${var.pvt_key} -e 'pub_key=${var.ideapad_key}' ovpn-install.yml"
    }
}
