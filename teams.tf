# Team and User Management

# Create teams for different departments
resource "konnect_team" "platform_team" {
  name        = "Platform Engineering"
  description = "Platform engineering team with full control plane access"
}

resource "konnect_team" "api_developers" {
  name        = "API Developers"
  description = "API development team with limited access"
}

resource "konnect_team" "operations_team" {
  name        = "Operations Team"
  description = "Operations team for monitoring and maintenance"
}

# Team Memberships - Add users to teams
# Note: Team memberships not supported in provider v3.1.0
# Users must be added to teams via Konnect UI
# resource "konnect_team_membership" "platform_lead" {
#   count   = var.enable_team_memberships ? 1 : 0
#   team_id = konnect_team.platform_team.id
#   user_id = var.platform_lead_user_id
# }

# resource "konnect_team_membership" "api_dev_member" {
#   count   = var.enable_team_memberships ? 1 : 0
#   team_id = konnect_team.api_developers.id
#   user_id = var.api_dev_user_id
# }

# Team Role Assignment - Assign roles to teams for control plane
resource "konnect_team_role" "platform_admin_role" {
  entity_id        = konnect_gateway_control_plane.terraform_cp.id
  entity_region    = var.konnect_region
  entity_type_name = "Control Planes"
  role_name        = "Admin"
  team_id          = konnect_team.platform_team.id
}

resource "konnect_team_role" "api_dev_role" {
  entity_id        = konnect_gateway_control_plane.terraform_cp.id
  entity_region    = var.konnect_region
  entity_type_name = "Control Planes"
  role_name        = "Admin"
  team_id          = konnect_team.api_developers.id
}

resource "konnect_team_role" "ops_viewer_role" {
  entity_id        = konnect_gateway_control_plane.terraform_cp.id
  entity_region    = var.konnect_region
  entity_type_name = "Control Planes"
  role_name        = "Viewer"
  team_id          = konnect_team.operations_team.id
}

# Portal Team Role - Allow teams to manage portal
resource "konnect_team_role" "platform_portal_admin" {
  entity_id        = konnect_portal.terraform_portal.id
  entity_region    = var.konnect_region
  entity_type_name = "Portals"
  role_name        = "Admin"
  team_id          = konnect_team.platform_team.id
}
