# Certificates and Custom Plugin Schemas

# CA Certificate for mTLS
resource "konnect_gateway_ca_certificate" "root_ca" {
  count            = var.enable_mtls ? 1 : 0
  cert             = var.ca_certificate
  control_plane_id = local.control_plane_id

  tags = ["mtls", "root-ca"]
}

# CA Certificate for client verification
resource "konnect_gateway_ca_certificate" "client_ca" {
  count            = var.enable_mtls ? 1 : 0
  cert             = var.client_ca_certificate
  control_plane_id = local.control_plane_id

  tags = ["mtls", "client-ca"]
}

# Server Certificate
resource "konnect_gateway_certificate" "server_cert" {
  count            = var.enable_custom_domain ? 1 : 0
  cert             = var.server_certificate
  key              = var.server_private_key
  control_plane_id = local.control_plane_id

  tags = ["tls", "server"]
}

# SNI for custom domain
resource "konnect_gateway_sni" "api_domain" {
  count            = var.enable_custom_domain ? 1 : 0
  name             = var.custom_domain
  control_plane_id = local.control_plane_id

  certificate = {
    id = konnect_gateway_certificate.server_cert[0].id
  }

  tags = ["custom-domain"]
}

# Custom Plugin Schema (Not supported in provider v3.1.0)
# resource "konnect_gateway_plugin_schema" "custom_auth_plugin" {
#   count            = var.enable_custom_plugin ? 1 : 0
#   lua_schema       = var.custom_plugin_lua_schema
#   control_plane_id = local.control_plane_id
# }

# Key for signing/verification
resource "konnect_gateway_key" "signing_key" {
  count            = var.enable_key_management ? 1 : 0
  name             = "jwt-signing-key"
  control_plane_id = local.control_plane_id

  jwk = var.jwk_key
  kid = "key-1"
  pem = {
    private_key = var.signing_private_key
    public_key  = var.signing_public_key
  }

  tags = ["jwt", "signing"]
}

# Key Set for managing multiple keys
resource "konnect_gateway_key_set" "jwt_key_set" {
  count            = var.enable_key_management ? 1 : 0
  name             = "jwt-keys"
  control_plane_id = local.control_plane_id

  tags = ["jwt", "key-rotation"]
}
