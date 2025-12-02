# Data Plane Configuration

# Data Plane Client Certificate
resource "konnect_gateway_data_plane_client_certificate" "dp_cert" {
  count            = var.enable_dp_client_cert ? 1 : 0
  cert             = var.dp_client_certificate
  control_plane_id = local.control_plane_id
}

# System Account for Data Plane
resource "konnect_system_account" "dataplane_system_account" {
  count           = var.enable_system_account ? 1 : 0
  name            = "data-plane-system-account"
  description     = "System account for data plane authentication"
  konnect_managed = false
}

# System Account Access Token
resource "konnect_system_account_access_token" "dp_token" {
  count      = var.enable_system_account ? 1 : 0
  account_id = konnect_system_account.dataplane_system_account[0].id
  name       = "data-plane-token"
  expires_at = var.system_account_token_expiry
}

# System Account Role Assignment
resource "konnect_system_account_role" "dp_admin_role" {
  count            = var.enable_system_account ? 1 : 0
  account_id       = konnect_system_account.dataplane_system_account[0].id
  entity_id        = konnect_gateway_control_plane.terraform_cp.id
  entity_region    = var.konnect_region
  entity_type_name = "Control Planes"
  role_name        = "Admin"
}

# Cloud Gateway Configuration (for managed data planes)
# Cloud Gateway Configuration
# Note: Commented out - requires cloud_gateway_network_id which must be created separately
# resource "konnect_cloud_gateway_configuration" "cloud_gw_config" {
#   count              = var.enable_cloud_gateway ? 1 : 0
#   control_plane_id   = local.control_plane_id
#   control_plane_geo  = var.control_plane_geo
#   version            = var.cloud_gateway_version
#   
#   dataplane_groups = [
#     {
#       provider = var.cloud_gateway_provider
#       region   = var.cloud_gateway_region
#       cloud_gateway_network_id = "<network_id_required>"
#       autoscale = {
#         kind = var.cloud_gateway_autoscale_kind
#         configuration = {
#           base_rps       = var.cloud_gateway_base_rps
#           max_rps        = var.cloud_gateway_max_rps
#           kind           = var.cloud_gateway_autoscale_kind
#         }
#       }
#     }
#   ]
# }

# Network Configuration for Cloud Gateway (Not supported in provider v3.1.0)
# resource "konnect_cloud_gateway_network_configuration" "cloud_gw_network" {
#   count                         = var.enable_cloud_gateway ? 1 : 0
#   control_plane_id              = local.control_plane_id
#   dataplane_group_id            = var.dataplane_group_id
#   
#   egress_ip_addresses           = var.egress_ip_addresses
#   firewall_allowed_ip_addresses = var.firewall_allowed_ips
# }

# Custom Domain for Cloud Gateway
resource "konnect_cloud_gateway_custom_domain" "api_domain" {
  count             = var.enable_cloud_gateway_custom_domain ? 1 : 0
  control_plane_id  = local.control_plane_id
  control_plane_geo = var.control_plane_geo
  domain            = var.cloud_gateway_custom_domain
}

# Transit Gateway Attachment (Not supported - use network_id parameter)
# resource "konnect_cloud_gateway_transit_gateway" "tgw" {
#   count                  = var.enable_transit_gateway ? 1 : 0
#   network_id             = var.network_id
#   aws_ram_share_arn      = var.aws_ram_share_arn
#   aws_transit_gateway_id = var.aws_transit_gateway_id
#   cidrs                  = var.transit_gateway_cidrs
# }

# Private Network Peering (Not supported in provider v3.1.0)
# resource "konnect_cloud_gateway_provider_account" "cloud_provider" {
#   count            = var.enable_provider_account ? 1 : 0
#   control_plane_id = local.control_plane_id
#   
#   configuration = {
#     kind = var.cloud_provider_kind
#     aws = var.cloud_provider_kind == "aws" ? {
#       account_id          = var.aws_account_id
#       arn                 = var.aws_arn
#       external_id         = var.aws_external_id
#       konnect_account_id  = var.konnect_account_id
#     } : null
#     azure = var.cloud_provider_kind == "azure" ? {
#       subscription_id     = var.azure_subscription_id
#       tenant_id           = var.azure_tenant_id
#     } : null
#   }
# }
