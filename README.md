Transit Gateway Module

This module creates following primary resources:
 1. Transit Gateway
 2. Customer Gateways
 3. VPN Connections
 4. Transit Gateway Attachments

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.25.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_customer_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_ec2_tag.cgw_vpn_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_transit_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway) | resource |
| [aws_ec2_transit_gateway_route.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_association.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_ram_principal_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_ram_resource_share_accepter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share_accepter) | resource |
| [aws_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpn_connection.cgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_vpn_connection.vgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_vpn_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway) | resource |
| [aws_ec2_transit_gateway_vpn_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway_vpn_attachment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amazon_side_asn"></a> [amazon\_side\_asn](#input\_amazon\_side\_asn) | Private Autonomous System Number (ASN) for the Amazon side of a BGP session | `number` | `64512` | no |
| <a name="input_auto_accept_shared_attachments"></a> [auto\_accept\_shared\_attachments](#input\_auto\_accept\_shared\_attachments) | Whether resource attachment requests are automatically accepted | `bool` | `false` | no |
| <a name="input_cgw_vpn_connections"></a> [cgw\_vpn\_connections](#input\_cgw\_vpn\_connections) | Map of maps for VPN connections to be created | `any` | `{}` | no |
| <a name="input_create_tgw"></a> [create\_tgw](#input\_create\_tgw) | Controls if TGW should be created (it affects almost all resources) | `bool` | `true` | no |
| <a name="input_customer_gateways"></a> [customer\_gateways](#input\_customer\_gateways) | Map of maps for customer gateways to be created | `any` | `{}` | no |
| <a name="input_default_route_table_association"></a> [default\_route\_table\_association](#input\_default\_route\_table\_association) | Whether resource attachments are automatically associated with the default association route table | `bool` | `true` | no |
| <a name="input_default_route_table_name"></a> [default\_route\_table\_name](#input\_default\_route\_table\_name) | Name of the default TGW route table | `string` | `""` | no |
| <a name="input_default_route_table_propagation"></a> [default\_route\_table\_propagation](#input\_default\_route\_table\_propagation) | Whether resource attachments automatically propagate routes to the default propagation route table | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Provide Transit Gateway description | `string` | `""` | no |
| <a name="input_dns_support"></a> [dns\_support](#input\_dns\_support) | Whether DNS support is enabled | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Provide appropriate environment name | `string` | n/a | yes |
| <a name="input_import_ram_share_accepter"></a> [import\_ram\_share\_accepter](#input\_import\_ram\_share\_accepter) | Whether or not to import RAM share accepter resource | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name tag for all resources | `string` | `""` | no |
| <a name="input_ram_allow_external_principals"></a> [ram\_allow\_external\_principals](#input\_ram\_allow\_external\_principals) | Indicates whether principals outside your organization can be associated with a resource share. | `bool` | `false` | no |
| <a name="input_ram_name"></a> [ram\_name](#input\_ram\_name) | The name of the resource share of TGW | `string` | `""` | no |
| <a name="input_ram_principals"></a> [ram\_principals](#input\_ram\_principals) | A list of principals to share TGW with. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN | `list(string)` | `[]` | no |
| <a name="input_ram_resource_share_arn"></a> [ram\_resource\_share\_arn](#input\_ram\_resource\_share\_arn) | ARN of RAM resource share | `string` | `""` | no |
| <a name="input_ram_tags"></a> [ram\_tags](#input\_ram\_tags) | Additional tags for RAM | `map(string)` | `{}` | no |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | Transit Gateway Route table name | `string` | `""` | no |
| <a name="input_route_tables"></a> [route\_tables](#input\_route\_tables) | Map of route tables | `any` | `{}` | no |
| <a name="input_share_tgw"></a> [share\_tgw](#input\_share\_tgw) | Whether to share your transit gateway with other accounts | `bool` | `true` | no |
| <a name="input_tag_application"></a> [tag\_application](#input\_tag\_application) | Application tag | `string` | n/a | yes |
| <a name="input_tag_team"></a> [tag\_team](#input\_tag\_team) | Team tag | `string` | n/a | yes |
| <a name="input_tgw_attachment_name"></a> [tgw\_attachment\_name](#input\_tgw\_attachment\_name) | Transit Gateway attachment name | `string` | `""` | no |
| <a name="input_tgw_default_route_table_tags"></a> [tgw\_default\_route\_table\_tags](#input\_tgw\_default\_route\_table\_tags) | Additional tags for the Default TGW route table | `map(string)` | `{}` | no |
| <a name="input_tgw_name"></a> [tgw\_name](#input\_tgw\_name) | Transit Gateway name | `string` | `""` | no |
| <a name="input_tgw_route_table_tags"></a> [tgw\_route\_table\_tags](#input\_tgw\_route\_table\_tags) | Additional tags for the TGW route table | `map(string)` | `{}` | no |
| <a name="input_tgw_tags"></a> [tgw\_tags](#input\_tgw\_tags) | Additional tags for the TGW | `map(string)` | `{}` | no |
| <a name="input_tgw_vpc_attachment_tags"></a> [tgw\_vpc\_attachment\_tags](#input\_tgw\_vpc\_attachment\_tags) | Additional tags for VPC attachments | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_route_table_id"></a> [transit\_gateway\_route\_table\_id](#input\_transit\_gateway\_route\_table\_id) | Identifier of EC2 Transit Gateway Route Table to use with the Target Gateway when reusing it between multiple TGWs | `string` | `null` | no |
| <a name="input_vgw_vpn_connections"></a> [vgw\_vpn\_connections](#input\_vgw\_vpn\_connections) | Map of maps for VPN connections to be created | `any` | `{}` | no |
| <a name="input_vpc_attachments"></a> [vpc\_attachments](#input\_vpc\_attachments) | Maps of maps of VPC details to attach to TGW. | `any` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | `""` | no |
| <a name="input_vpn_attachments"></a> [vpn\_attachments](#input\_vpn\_attachments) | Maps of maps of VPN details to attach to TGW. | `any` | `{}` | no |
| <a name="input_vpn_ecmp_support"></a> [vpn\_ecmp\_support](#input\_vpn\_ecmp\_support) | Whether VPN Equal Cost Multipath Protocol support is enabled | `bool` | `true` | no |
| <a name="input_vpn_gateways"></a> [vpn\_gateways](#input\_vpn\_gateways) | Map of maps for vpn gateways to be created | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cgw_id"></a> [cgw\_id](#output\_cgw\_id) | Map of Customer Gateway IDs |
| <a name="output_cgw_vpn_connections"></a> [cgw\_vpn\_connections](#output\_cgw\_vpn\_connections) | Map of VPN Connections |
| <a name="output_ec2_transit_gateway_arn"></a> [ec2\_transit\_gateway\_arn](#output\_ec2\_transit\_gateway\_arn) | EC2 Transit Gateway Amazon Resource Name (ARN) |
| <a name="output_ec2_transit_gateway_association_default_route_table_id"></a> [ec2\_transit\_gateway\_association\_default\_route\_table\_id](#output\_ec2\_transit\_gateway\_association\_default\_route\_table\_id) | Identifier of the default association route table |
| <a name="output_ec2_transit_gateway_id"></a> [ec2\_transit\_gateway\_id](#output\_ec2\_transit\_gateway\_id) | EC2 Transit Gateway identifier |
| <a name="output_ec2_transit_gateway_owner_id"></a> [ec2\_transit\_gateway\_owner\_id](#output\_ec2\_transit\_gateway\_owner\_id) | Identifier of the AWS account that owns the EC2 Transit Gateway |
| <a name="output_ec2_transit_gateway_propagation_default_route_table_id"></a> [ec2\_transit\_gateway\_propagation\_default\_route\_table\_id](#output\_ec2\_transit\_gateway\_propagation\_default\_route\_table\_id) | Identifier of the default propagation route table |
| <a name="output_ec2_transit_gateway_route_table_association"></a> [ec2\_transit\_gateway\_route\_table\_association](#output\_ec2\_transit\_gateway\_route\_table\_association) | Map of EC2 Transit Gateway Route Table Association attributes |
| <a name="output_ec2_transit_gateway_route_table_association_ids"></a> [ec2\_transit\_gateway\_route\_table\_association\_ids](#output\_ec2\_transit\_gateway\_route\_table\_association\_ids) | List of EC2 Transit Gateway Route Table Association identifiers |
| <a name="output_ec2_transit_gateway_route_table_propagation"></a> [ec2\_transit\_gateway\_route\_table\_propagation](#output\_ec2\_transit\_gateway\_route\_table\_propagation) | Map of EC2 Transit Gateway Route Table Propagation attributes |
| <a name="output_ec2_transit_gateway_route_table_propagation_ids"></a> [ec2\_transit\_gateway\_route\_table\_propagation\_ids](#output\_ec2\_transit\_gateway\_route\_table\_propagation\_ids) | List of EC2 Transit Gateway Route Table Propagation identifiers |
| <a name="output_ec2_transit_gateway_vpc_attachment"></a> [ec2\_transit\_gateway\_vpc\_attachment](#output\_ec2\_transit\_gateway\_vpc\_attachment) | Map of EC2 Transit Gateway VPC Attachment attributes |
| <a name="output_ec2_transit_gateway_vpc_attachment_ids"></a> [ec2\_transit\_gateway\_vpc\_attachment\_ids](#output\_ec2\_transit\_gateway\_vpc\_attachment\_ids) | List of EC2 Transit Gateway VPC Attachment identifiers |
| <a name="output_ram_principal_association_id"></a> [ram\_principal\_association\_id](#output\_ram\_principal\_association\_id) | The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma |
| <a name="output_ram_resource_share_id"></a> [ram\_resource\_share\_id](#output\_ram\_resource\_share\_id) | The Amazon Resource Name (ARN) of the resource share |
| <a name="output_vgw_id"></a> [vgw\_id](#output\_vgw\_id) | VGW ID |
| <a name="output_vgw_vpn_connections"></a> [vgw\_vpn\_connections](#output\_vgw\_vpn\_connections) | Map of VPN Connections |
