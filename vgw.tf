resource "aws_vpn_gateway" "this" {
  for_each        = var.vpn_gateways
  vpc_id          = var.vpc_id
  amazon_side_asn = each.value["amazon_side_asn"]


  tags = merge(
    {
      Name = each.value["vgw_name"]
    }
  )
}