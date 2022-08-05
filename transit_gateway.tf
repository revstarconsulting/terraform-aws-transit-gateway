resource "aws_ec2_transit_gateway" "this" {
  count                           = var.create_tgw ? 1 : 0
  description                     = "Transit Gateway in ${var.environment} env"
  amazon_side_asn                 = var.amazon_side_asn
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments ? "enable" : "disable"
  default_route_table_association = var.default_route_table_association ? "enable" : "disable"
  default_route_table_propagation = var.default_route_table_propagation ? "enable" : "disable"
  dns_support                     = var.dns_support ? "enable" : "disable"
  vpn_ecmp_support                = var.vpn_ecmp_support ? "enable" : "disable"
  tags = merge(
    {
      "Name" = var.tgw_name
    },
    local.common_tags,
    var.tgw_tags
  )
}

/*
resource "aws_ec2_tag" "this" {
  #for_each    = var.create_tgw ? local.tgw_default_route_table_tags_merged : {}
  count       = var.create_tgw ? 1 : 0
  resource_id = aws_ec2_transit_gateway.this[0].association_default_route_table_id
  key         = "Name"
  value       = var.default_route_table_name
}
*/