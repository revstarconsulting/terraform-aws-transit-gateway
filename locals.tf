
locals {
  vpc_attachments_without_default_route_table_association = {
    for k, v in var.vpc_attachments : k => v if lookup(v, "transit_gateway_default_route_table_association", true) != true
  }

  vpc_attachments_without_default_route_table_propagation = {
    for k, v in var.vpc_attachments : k => v if lookup(v, "transit_gateway_default_route_table_propagation", true) != true
  }

  vpn_attachments_without_default_route_table_association = {
    for k, v in var.vpn_attachments : k => v if lookup(v, "transit_gateway_default_route_table_association", true) != true
  }

  vpn_attachments_without_default_route_table_propagation = {
    for k, v in var.vpn_attachments : k => v if(lookup(v, "transit_gateway_default_route_table_propagation", true) != true && lookup(v, "static_routes_enabled", false) != true)
  }

  # List of maps with key and route values
  vpc_attachments_with_routes = chunklist(flatten([
    for k, v in var.vpc_attachments : setproduct([{ key = k }], v["tgw_routes"]) if length(lookup(v, "tgw_routes", {})) > 0
  ]), 2)

  vpn_attachments_with_routes = chunklist(flatten([
    for k, v in var.vpn_attachments : setproduct([{ key = k }], v["tgw_routes"]) if length(lookup(v, "tgw_routes", {})) > 0
  ]), 2)

  tgw_default_route_table_tags_merged = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tgw_default_route_table_tags,
  )

  vpc_route_table_destination_cidr = flatten([
    for k, v in var.vpc_attachments : [
      for rtb_id in lookup(v, "vpc_route_table_ids", []) : {
        rtb_id = rtb_id
        cidr   = v["tgw_destination_cidr"]
      }
    ]
  ])
}