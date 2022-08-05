
resource "aws_vpn_connection" "cgw" {
  for_each = var.cgw_vpn_connections

  transit_gateway_id  = lookup(each.value, "transit_gateway_id", aws_ec2_transit_gateway.this[0].id)
  customer_gateway_id = aws_customer_gateway.this[each.value["cgw_key"]].id
  type                = lookup(each.value, "type", "ipsec.1")
  static_routes_only  = lookup(each.value, "static_routes_enabled", true)
  #Tunnel details
  tunnel1_ike_versions = lookup(each.value, "tunnel1_ike_versions", null)
  tunnel2_ike_versions = lookup(each.value, "tunnel2_ike_versions", null)

  tunnel1_dpd_timeout_action = lookup(each.value, "tunnel1_dpd_timeout_action", null)
  tunnel2_dpd_timeout_action = lookup(each.value, "tunnel2_dpd_timeout_action", null)

  tunnel1_phase1_dh_group_numbers = lookup(each.value, "tunnel1_phase1_dh_group_numbers", null)
  tunnel2_phase1_dh_group_numbers = lookup(each.value, "tunnel2_phase1_dh_group_numbers", null)

  tunnel1_phase1_encryption_algorithms = lookup(each.value, "tunnel1_phase1_encryption_algorithms", null)
  tunnel2_phase1_encryption_algorithms = lookup(each.value, "tunnel2_phase1_encryption_algorithms", null)

  tunnel1_phase1_integrity_algorithms = lookup(each.value, "tunnel1_phase1_integrity_algorithms", null)
  tunnel2_phase1_integrity_algorithms = lookup(each.value, "tunnel2_phase1_integrity_algorithms", null)

  tunnel1_phase2_dh_group_numbers = lookup(each.value, "tunnel1_phase2_dh_group_numbers", null)
  tunnel2_phase2_dh_group_numbers = lookup(each.value, "tunnel2_phase2_dh_group_numbers", null)

  tunnel1_phase2_encryption_algorithms = lookup(each.value, "tunnel1_phase2_encryption_algorithms", null)
  tunnel2_phase2_encryption_algorithms = lookup(each.value, "tunnel2_phase2_encryption_algorithms", null)

  tunnel1_phase2_integrity_algorithms = lookup(each.value, "tunnel1_phase2_integrity_algorithms", null)
  tunnel2_phase2_integrity_algorithms = lookup(each.value, "tunnel2_phase2_integrity_algorithms", null)

  tunnel1_startup_action = lookup(each.value, "tunnel1_startup_action", null)
  tunnel2_startup_action = lookup(each.value, "tunnel2_startup_action", null)



  tags = merge(
    {
      Name = each.value["vpn_name"]
    }
  )
}

resource "aws_ec2_tag" "cgw_vpn_attachment" {
  for_each = var.cgw_vpn_connections

  key         = "Name"
  value       = each.value["vpn_name"]
  resource_id = aws_vpn_connection.cgw[each.key].transit_gateway_attachment_id

}

resource "aws_vpn_connection" "vgw" {
  for_each = var.vgw_vpn_connections

  vpn_gateway_id      = aws_vpn_gateway.this[each.value["vpn_gw_key"]].id
  customer_gateway_id = aws_customer_gateway.this[each.value["cgw_key"]].id
  type                = lookup(each.value, "type", "ipsec.1")
  static_routes_only  = lookup(each.value, "static_routes_enabled", false)

  #Tunnel details
  tunnel1_ike_versions = lookup(each.value, "tunnel1_ike_versions", null)
  tunnel2_ike_versions = lookup(each.value, "tunnel2_ike_versions", null)

  tunnel1_phase1_dh_group_numbers = lookup(each.value, "tunnel1_phase1_dh_group_numbers", null)
  tunnel2_phase1_dh_group_numbers = lookup(each.value, "tunnel2_phase1_dh_group_numbers", null)

  tunnel1_phase1_encryption_algorithms = lookup(each.value, "tunnel1_phase1_encryption_algorithms", null)
  tunnel2_phase1_encryption_algorithms = lookup(each.value, "tunnel2_phase1_encryption_algorithms", null)

  tunnel1_phase1_integrity_algorithms = lookup(each.value, "tunnel1_phase1_integrity_algorithms", null)
  tunnel2_phase1_integrity_algorithms = lookup(each.value, "tunnel2_phase1_integrity_algorithms", null)

  tunnel1_phase2_dh_group_numbers = lookup(each.value, "tunnel1_phase2_dh_group_numbers", null)
  tunnel2_phase2_dh_group_numbers = lookup(each.value, "tunnel2_phase2_dh_group_numbers", null)

  tunnel1_phase2_encryption_algorithms = lookup(each.value, "tunnel1_phase2_encryption_algorithms", null)
  tunnel2_phase2_encryption_algorithms = lookup(each.value, "tunnel2_phase2_encryption_algorithms", null)

  tunnel1_phase2_integrity_algorithms = lookup(each.value, "tunnel1_phase2_integrity_algorithms", null)
  tunnel2_phase2_integrity_algorithms = lookup(each.value, "tunnel2_phase2_integrity_algorithms", null)

  tunnel1_startup_action = lookup(each.value, "tunnel1_startup_action", null)
  tunnel2_startup_action = lookup(each.value, "tunnel2_startup_action", null)
  tags = merge(
    {
      Name = each.value["vpn_name"]
    }
  )
}


resource "aws_ec2_transit_gateway_route_table_association" "vpn" {
  for_each = local.vpn_attachments_without_default_route_table_association

  # Create association if it was not set already by aws_ec2_transit_gateway_vpc_attachment resource
  transit_gateway_attachment_id  = data.aws_ec2_transit_gateway_vpn_attachment.this[each.key].id
  transit_gateway_route_table_id = coalesce(lookup(each.value, "transit_gateway_route_table_id", null), aws_ec2_transit_gateway_route_table.this[each.value["rtb_key"]].id)

}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpn" {
  for_each = local.vpn_attachments_without_default_route_table_propagation

  # Create association if it was not set already by aws_ec2_transit_gateway_vpc_attachment resource
  transit_gateway_attachment_id  = data.aws_ec2_transit_gateway_vpn_attachment.this[each.key].id
  transit_gateway_route_table_id = coalesce(lookup(each.value, "transit_gateway_route_table_id", null), aws_ec2_transit_gateway_route_table.this[each.value["rtb_key"]].id)

}
