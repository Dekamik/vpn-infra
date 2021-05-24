# Provisioning credentials
variable "token" {}
variable "pvt_key" {}

# Public keys
variable "ideapad_key" {}
variable "ideapad_key_ed25519" {}
variable "legion_key" {}

# VPN Regions
variable "regions" {
    description = "Map of regions"
    type = map
    default = {
        vpn-us = {
            linode_region = "us-east"
            type = "g6-nanode-1"
            image = "linode/ubuntu20.04"
        }
    }
}