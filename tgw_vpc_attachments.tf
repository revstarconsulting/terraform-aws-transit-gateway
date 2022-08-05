resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  for_each   = var.vpc_attachments
  subnet_ids = each.value["subnet_ids"]
  vpc_id     = each.value["vpc_id"]

  transit_gateway_id                              = lookup(each.value, "tgw_id", length(aws_ec2_transit_gateway.this.*.id) > 0 ? aws_ec2_transit_gateway.this[0].id : null)
  dns_support                                     = lookup(each.value, "dns_support", true) ? "enable" : "disable"
  appliance_mode_support                          = lookup(each.value, "appliance_mode_support", false) ? "enable" : "disable"
  transit_gateway_default_route_table_association = lookup(each.value, "transit_gateway_default_route_table_association", true)
  transit_gateway_default_route_table_propagation = lookup(each.value, "transit_gateway_default_route_table_propagation", true)


  tags = merge(
    {
      "Name" = each.value["tgw_attachment_name"]
    },
    local.common_tags,
    var.tgw_vpc_attachment_tags
  )
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  for_each = local.vpc_attachments_without_default_route_table_association

  # Create association if it was not set already by aws_ec2_transit_gateway_vpc_attachment resource
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this[each.key].id
  transit_gateway_route_table_id = coalesce(lookup(each.value, "transit_gateway_route_table_id", null), aws_ec2_transit_gateway_route_table.this[each.value["rtb_key"]].id)
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  for_each = local.vpc_attachments_without_default_route_table_propagation

  # Create association if it was not set already by aws_ec2_transit_gateway_vpc_attachment resource
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this[each.key].id
  transit_gateway_route_table_id = coalesce(lookup(each.value, "transit_gateway_route_table_id", null), aws_ec2_transit_gateway_route_table.this[each.value["rtb_key"]].id)

}