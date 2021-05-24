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

resource "linode_instance" "vpn-us" {
    label = "vpn-us"
    image = "linode/ubuntu20.04"
    region = "us-southeast"
    type = "g6-nanode-1"
    authorized_keys = [var.ideapad_key, var.ideapad_key_ed25519, var.legion_key]

    provisioner "remote-exec" {
        inline = [
            "echo 'export SERVER_NAME=vpn-us' >> ~/.profile",
            "sudo apt update",
            "sudo apt install python3 -y"
        ]

        connection {
            host = self.ip_address
            type = "ssh"
            user = "root"
            private_key = file(var.pvt_key)
        }
    }

    provisioner "local-exec" {
        command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ip_address},' --private-key ${var.pvt_key} -e 'pub_key=${var.ideapad_key}' provisioning/ovpn-install.yml"
    }
}
