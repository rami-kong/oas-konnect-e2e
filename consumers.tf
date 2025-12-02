# Consumer and Credential Management

# Consumer for API Key Authentication
resource "konnect_gateway_consumer" "api_key_consumer" {
  username         = "api-key-user"
  custom_id        = "api-key-user-001"
  control_plane_id = local.control_plane_id

  tags = ["api-key", "external"]
}

# API Key Credential
resource "konnect_gateway_key_auth" "api_key_credential" {
  consumer_id      = konnect_gateway_consumer.api_key_consumer.id
  key              = var.api_key_credential
  control_plane_id = local.control_plane_id

  tags = ["production"]
}

# Consumer for Basic Authentication
resource "konnect_gateway_consumer" "basic_auth_consumer" {
  username         = "basic-auth-user"
  custom_id        = "basic-auth-user-001"
  control_plane_id = local.control_plane_id

  tags = ["basic-auth", "internal"]
}

# Basic Auth Credential
resource "konnect_gateway_basic_auth" "basic_credential" {
  consumer_id      = konnect_gateway_consumer.basic_auth_consumer.id
  username         = var.basic_auth_username
  password         = var.basic_auth_password
  control_plane_id = local.control_plane_id

  tags = ["internal-api"]
}

# Consumer for JWT Authentication
resource "konnect_gateway_consumer" "jwt_consumer" {
  username         = "jwt-user"
  custom_id        = "jwt-user-001"
  control_plane_id = local.control_plane_id

  tags = ["jwt", "mobile-app"]
}

# JWT Credential
resource "konnect_gateway_jwt" "jwt_credential" {
  consumer_id      = konnect_gateway_consumer.jwt_consumer.id
  algorithm        = "HS256"
  key              = "jwt-issuer-key"
  secret           = var.jwt_secret
  control_plane_id = local.control_plane_id

  tags = ["mobile"]
}

# Consumer for HMAC Authentication
resource "konnect_gateway_consumer" "hmac_consumer" {
  username         = "hmac-user"
  custom_id        = "hmac-user-001"
  control_plane_id = local.control_plane_id

  tags = ["hmac", "partner-api"]
}

# HMAC Auth Credential
resource "konnect_gateway_hmac_auth" "hmac_credential" {
  consumer_id      = konnect_gateway_consumer.hmac_consumer.id
  username         = "hmac-partner"
  secret           = var.hmac_secret
  control_plane_id = local.control_plane_id

  tags = ["partner"]
}

# Consumer for ACL groups
resource "konnect_gateway_consumer" "premium_consumer" {
  username         = "premium-user"
  custom_id        = "premium-user-001"
  control_plane_id = local.control_plane_id

  tags = ["premium", "tier-1"]
}

# ACL group for premium users
resource "konnect_gateway_acl" "premium_group" {
  consumer_id      = konnect_gateway_consumer.premium_consumer.id
  group            = "premium-users"
  control_plane_id = local.control_plane_id

  tags = ["premium-tier"]
}

# Consumer group for rate limiting
resource "konnect_gateway_consumer_group" "premium_tier" {
  name             = "premium-tier"
  control_plane_id = local.control_plane_id

  tags = ["premium", "high-limit"]
}

# Add consumer to consumer group
resource "konnect_gateway_consumer_group_member" "premium_member" {
  consumer_id       = konnect_gateway_consumer.premium_consumer.id
  consumer_group_id = konnect_gateway_consumer_group.premium_tier.id
  control_plane_id  = local.control_plane_id
}

# OAuth2 Application - For OAuth2 authentication
resource "konnect_gateway_consumer" "oauth2_consumer" {
  username         = "oauth2-app"
  custom_id        = "oauth2-app-001"
  control_plane_id = local.control_plane_id

  tags = ["oauth2", "web-app"]
}

# OAuth2 Credential (Not supported in provider v3.1.0)
# Use Kong Admin API or Konnect UI to create OAuth2 credentials
# resource "konnect_gateway_oauth2_credential" "oauth2_app_credential" {
#   consumer_id      = konnect_gateway_consumer.oauth2_consumer.id
#   name             = "OAuth2 Web Application"
#   client_id        = var.oauth2_client_id
#   client_secret    = var.oauth2_client_secret
#   redirect_uris    = var.oauth2_redirect_uris
#   control_plane_id = local.control_plane_id
#
#   tags = ["web-application"]
# }
