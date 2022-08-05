resource "aws_customer_gateway" "this" {
  for_each = var.customer_gateways

  bgp_asn     = each.value["bgp_asn"]
  ip_address  = each.value["ip_address"]
  type        = lookup(each.value, "type", "ipsec.1")
  device_name = lookup(each.value, "device_name", null)

  tags = merge(
    {
      Name = each.value["cgw_name"]
    }
  )
  # lifecycle {
  #   ignore_changes = all
  # }
}
