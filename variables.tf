variable "token" {
    description = "Your Linode API token used to access your resources at Linode."
    type        = string
}

variable "pvt_key" {
    description = "Path to your private SSH key file."
    type        = string
    default     = "~/.ssh/id_rsa"
}

variable "download_dir" {
    description = "Path to a directory on your coputer to which all VPN-client files will be downloaded."
    type        = string
    default     = "~/vpn/"
}

variable "public_keys" {
    description = "A map of public ssh keys to add to authorized_keys on your VPN-servers."
    type        = map
}

variable "vpn_regions" {
    description = "A map containing configurations for the VPN servers to create."
    type        = map
}
