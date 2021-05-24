output "IP-addresses" {
  value = tomap({
    for k, r in linode_instance.vpn-servers : k => r.ip_address
  })
}