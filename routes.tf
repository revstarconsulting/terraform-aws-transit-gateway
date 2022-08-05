resource "aws_ec2_transit_gateway_route_table" "this" {
  for_each           = var.route_tables
  transit_gateway_id = aws_ec2_transit_gateway.this[0].id

  tags = merge(
    {
      "Name" = each.value["route_table_name"]
    },
    local.common_tags,
    var.tgw_route_table_tags
  )
}


resource "aws_ec2_transit_gateway_route" "vpc" {
  count = length(local.vpc_attachments_with_routes)

  destination_cidr_block = local.vpc_attachments_with_routes[count.index][1]["destination_cidr_block"]
  blackhole              = lookup(local.vpc_attachments_with_routes[count.index][1], "blackhole", null)

  transit_gateway_route_table_id = var.create_tgw ? aws_ec2_transit_gateway_route_table.this[local.vpc_attachments_with_routes[count.index][0]["key"]].id : var.transit_gateway_route_table_id
  transit_gateway_attachment_id  = tobool(lookup(local.vpc_attachments_with_routes[count.index][1], "blackhole", false)) == false ? aws_ec2_transit_gateway_vpc_attachment.this[local.vpc_attachments_with_routes[count.index][0]["key"]].id : null

}

resource "aws_ec2_transit_gateway_route" "vpn" {
  count = length(local.vpn_attachments_with_routes)
  #for_each = local.vpn_attachments_with_routes

  destination_cidr_block = local.vpn_attachments_with_routes[count.index][1]["destination_cidr_block"]
  blackhole              = lookup(local.vpn_attachments_with_routes[count.index][1], "blackhole", null)

  transit_gateway_route_table_id = var.create_tgw ? aws_ec2_transit_gateway_route_table.this[local.vpn_attachments_with_routes[count.index][0]["key"]].id : var.transit_gateway_route_table_id
  transit_gateway_attachment_id  = tobool(lookup(local.vpn_attachments_with_routes[count.index][1], "blackhole", false)) == false ? data.aws_ec2_transit_gateway_vpn_attachment.this[local.vpn_attachments_with_routes[count.index][0]["key"]].id : null
}

resource "aws_route" "this" {
  for_each = { for x in local.vpc_route_table_destination_cidr : x.rtb_id => x.cidr }

  route_table_id         = each.key
  destination_cidr_block = each.value
  transit_gateway_id     = var.create_tgw ? aws_ec2_transit_gateway.this[0].id : data.aws_ec2_transit_gateway.this.id
}