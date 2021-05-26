# Provisioning
variable "token" {
    description = "Linode API token."
    type = string
}
variable "pvt_key" {
    description = "Path to private SSH key."
    type = string
    default = "~/.ssh/id_rsa"
}
variable "download_dir" {
    description = "Path to directory where VPN-client files will be downloaded."
    type = string
    default = "~/vpn/"
}

variable "public_keys" {
    description = "List of public ssh keys to add to your servers."
    type = map
}

variable "vpn_regions" {
    description = "Map of VPN servers to create"
    type = map
    default = {
        vpn-us = {
            linode_region = "us-east"
            type = "g6-nanode-1"
            image = "linode/ubuntu20.04"
        }
    }
}