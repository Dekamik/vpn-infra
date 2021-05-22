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
