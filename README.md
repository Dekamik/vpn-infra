# vpn-infra

This terraform repository creates OpenVPN-servers on virtual Linux servers on Linode.

## Getting started

### Pre-requisites

This project require these programs to run:

* OpenSSH
* Terraform
* Ansible

You must also have generated an SSH key for your computer. As of 2021-05-26 it has to use the RSA algorithm, not ED25519. 

You must also have created an account on Linode as well as generated an API Token for your account.

### Configuring your VPN servers

To configure your environment you need to create a file named `terraform.tfvars`. This is where you will override all variables defined in `variables.tf`.

`Example - terraform.tfvars`
```terraform
# Provisioning
token        = "<YOUR LINODE API KEY>"
download_dir = "~/Path/To/VPN/Folder/"

# Public keys
public_keys = {
    laptop_key = "<YOUR PUBLIC SSH KEY>"
    pc_key     = "<YOUR PUBLIC SSH KEY>"
}

vpn_regions = {
    vpn-us = {
        linode_region = "us-east"
        type          = "g6-nanode-1"
        image         = "linode/ubuntu20.04"
    },
    vpn-uk = {
        linode_region = "eu-west"
        type          = "g6-nanode-1"
        image         = "linode/ubuntu20.04"
    }
}
```

### Creating your VPN servers

Now that you've created your configuration, it's time to create your servers.

1. Open the root folder (containing this `README.md`) in a terminal.
2. Run `terraform init` to initialize this terraform project
3. Run `terraform plan` to check your configuration
4. If all is clear, run `terraform apply` to start the provisioning.

When these commands are run the above configuration in `terraform.tfvars` will create 2 virtual VPN-servers, upload `laptop_key` and `pc_key` as authorized keys for SSH login and download the VPN client files (`vpn-us.ovpn` and `vpn-uk.ovpn`) to `~/Path/To/VPN/Folder/`.

And boom! Now you have your own VPN-servers.
