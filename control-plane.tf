# control-plane.tf
resource "konnect_gateway_control_plane" "terraform_cp" {
  name         = var.control_plane_name
  description  = var.control_plane_description
  cluster_type = "CLUSTER_TYPE_CONTROL_PLANE"

  labels = {
    environment = var.environment
    managed_by  = "terraform"
    team        = "platform"
  }
}

resource "konnect_portal" "terraform_portal" {
  name                      = var.portal_name
  display_name              = "Developer Portal"
  description               = "Kong Konnect API Developer Portal - Managed by Terraform"
  force_destroy             = var.portal_force_destroy
  default_api_visibility    = var.default_api_visibility
  default_page_visibility   = "public"
  auto_approve_developers   = var.auto_approve_developers
  auto_approve_applications = var.auto_approve_applications
  authentication_enabled    = var.portal_auth_enabled
  rbac_enabled              = var.portal_rbac_enabled

  # Note: custom_domain not supported in portal resource
  # Configure custom domain separately if needed

  labels = {
    environment = var.environment
    managed_by  = "terraform"
  }
}