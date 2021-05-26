terraform {
    required_providers {
        linode = {
            source  = "linode/linode"
            version = "1.16.0"
        }
    }
}

provider "linode" {
    token = var.token
}

resource "linode_instance" "vpn-servers" {
    for_each = var.vpn_regions

    label           = each.key
    image           = each.value.image
    region          = each.value.linode_region
    type            = each.value.type
    authorized_keys = values(var.public_keys)

    provisioner "remote-exec" {
        inline = [
            "sudo apt update",
            "sudo apt install python3 -y"
        ]

        connection {
            host        = self.ip_address
            type        = "ssh"
            user        = "root"
            private_key = file(var.pvt_key)
        }
    }

    provisioner "local-exec" {
        command = "ansible-playbook -u root -i '${self.ip_address},' --private-key ${var.pvt_key} -e 'server_name=${each.key} dl_dir=${var.download_dir}' provisioning/ovpn-install.yml"
    }
}
