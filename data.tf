data "aws_ec2_transit_gateway_vpn_attachment" "this" {
  for_each = var.vpn_attachments

  transit_gateway_id = lookup(each.value, "transit_gateway_id", aws_ec2_transit_gateway.this[0].id)
  vpn_connection_id  = aws_vpn_connection.cgw[each.key].id
  tags = {
    Name = each.value["vpn_name"]
  }

}

data "aws_ec2_transit_gateway" "this" {}
