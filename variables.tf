variable "name" {
  description = "Name tag for all resources"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = ""
}
variable "create_tgw" {
  description = "Controls if TGW should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "tgw_name" {
  description = "Transit Gateway name"
  type        = string
  default     = ""
}

variable "tgw_attachment_name" {
  description = "Transit Gateway attachment name"
  type        = string
  default     = ""
}
variable "description" {
  description = "Provide Transit Gateway description"
  type        = string
  default     = ""
}

variable "amazon_side_asn" {
  description = "Private Autonomous System Number (ASN) for the Amazon side of a BGP session"
  type        = number
  default     = 64512
}

variable "auto_accept_shared_attachments" {
  description = "Whether resource attachment requests are automatically accepted"
  type        = bool
  default     = false
}

variable "route_tables" {
  description = "Map of route tables"
  type        = any
  default     = {}
}

variable "route_table_name" {
  description = "Transit Gateway Route table name"
  type        = string
  default     = ""
}

variable "default_route_table_name" {
  description = "Name of the default TGW route table"
  type        = string
  default     = ""
}
variable "default_route_table_association" {
  description = "Whether resource attachments are automatically associated with the default association route table"
  type        = bool
  default     = true
}

variable "default_route_table_propagation" {
  description = "Whether resource attachments automatically propagate routes to the default propagation route table"
  type        = bool
  default     = true
}

variable "dns_support" {
  description = "Whether DNS support is enabled"
  type        = bool
  default     = true
}

variable "vpn_ecmp_support" {
  description = "Whether VPN Equal Cost Multipath Protocol support is enabled"
  type        = bool
  default     = true

}

variable "vpc_attachments" {
  description = "Maps of maps of VPC details to attach to TGW."
  type        = any
  default     = {}
}

variable "vpn_attachments" {
  description = "Maps of maps of VPN details to attach to TGW."
  type        = any
  default     = {}
}

variable "transit_gateway_route_table_id" {
  description = "Identifier of EC2 Transit Gateway Route Table to use with the Target Gateway when reusing it between multiple TGWs"
  type        = string
  default     = null
}

variable "share_tgw" {
  description = "Whether to share your transit gateway with other accounts"
  type        = bool
  default     = true
}

variable "ram_name" {
  description = "The name of the resource share of TGW"
  type        = string
  default     = ""
}

variable "ram_allow_external_principals" {
  description = "Indicates whether principals outside your organization can be associated with a resource share."
  type        = bool
  default     = false
}

variable "ram_principals" {
  description = "A list of principals to share TGW with. Possible values are an AWS account ID, an AWS Organizations Organization ARN, or an AWS Organizations Organization Unit ARN"
  type        = list(string)
  default     = []
}

variable "ram_resource_share_arn" {
  description = "ARN of RAM resource share"
  type        = string
  default     = ""
}

variable "import_ram_share_accepter" {
  description = "Whether or not to import RAM share accepter resource"
  type        = bool
  default     = false
}

#VPN
variable "cgw_vpn_connections" {
  description = "Map of maps for VPN connections to be created"
  type        = any
  default     = {}
}

variable "vgw_vpn_connections" {
  description = "Map of maps for VPN connections to be created"
  type        = any
  default     = {}
}
#CGW
variable "customer_gateways" {
  description = "Map of maps for customer gateways to be created"
  type        = any
  default     = {}
}

#VGW
variable "vpn_gateways" {
  description = "Map of maps for vpn gateways to be created"
  type        = any
  default     = {}
}

#Tags
variable "tgw_tags" {
  description = "Additional tags for the TGW"
  type        = map(string)
  default     = {}
}

variable "tgw_route_table_tags" {
  description = "Additional tags for the TGW route table"
  type        = map(string)
  default     = {}
}

variable "tgw_default_route_table_tags" {
  description = "Additional tags for the Default TGW route table"
  type        = map(string)
  default     = {}
}

variable "tgw_vpc_attachment_tags" {
  description = "Additional tags for VPC attachments"
  type        = map(string)
  default     = {}
}

variable "ram_tags" {
  description = "Additional tags for RAM"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Provide appropriate environment name"
  type        = string

  validation {
    condition = contains([
      "dev",
      "development",
      "uat",
      "production",
      "prod",
      "sandbox",
      "transit",
      "shared"
    ], var.environment)

    error_message = "The environment value is not valid. Valid values are dev/development/uat/prod/production/sandbox/transit/shared."
  }
}


variable "tag_application" {
  description = "Application tag"
  type        = string

}

variable "tag_team" {
  description = "Team tag"
  type        = string

}

locals {
  common_tags = {
    Application = var.tag_application
    Team        = var.tag_team
    environment = var.environment
  }
}
