# Additional Kong Gateway Plugins

# Key Authentication Plugin
resource "konnect_gateway_plugin_key_auth" "api_key_auth" {
  enabled = var.enable_key_auth

  config = {
    key_names        = ["apikey", "x-api-key"]
    key_in_header    = true
    key_in_query     = false
    key_in_body      = false
    hide_credentials = true
    anonymous        = null
    run_on_preflight = true
  }

  service = {
    id = konnect_gateway_service.httpbin_api.id
  }

  control_plane_id = local.control_plane_id
}

# Basic Authentication Plugin
resource "konnect_gateway_plugin_basic_auth" "basic_auth" {
  enabled = var.enable_basic_auth

  config = {
    hide_credentials = true
    anonymous        = null
  }

  route = {
    id = konnect_gateway_route.post_anything.id
  }

  control_plane_id = local.control_plane_id
}

# JWT Plugin
resource "konnect_gateway_plugin_jwt" "jwt_auth" {
  enabled = var.enable_jwt_auth

  config = {
    uri_param_names    = ["jwt"]
    key_claim_name     = "iss"
    secret_is_base64   = false
    claims_to_verify   = ["exp"]
    header_names       = ["authorization"]
    anonymous          = null
    run_on_preflight   = true
    maximum_expiration = 31536000
  }

  route = {
    id = konnect_gateway_route.get_anything.id
  }

  control_plane_id = local.control_plane_id
}

# OAuth2 Plugin (Not supported in provider v3.1.0)
# Use konnect_gateway_plugin_openid_connect for OAuth2/OIDC authentication
# resource "konnect_gateway_plugin_oauth2" "oauth2" {
#   count   = var.enable_oauth2 ? 1 : 0
#   enabled = true
#
#   config = {
#     scopes                    = ["email", "profile", "openid"]
#     mandatory_scope           = true
#     enable_authorization_code = true
#     enable_client_credentials = true
#     enable_implicit_grant     = false
#     enable_password_grant     = true
#     token_expiration          = 7200
#     refresh_token_ttl         = 1209600
#     auth_header_name          = "authorization"
#   }
#
#   service = {
#     id = konnect_gateway_service.httpbin_api.id
#   }
#
#   control_plane_id = local.control_plane_id
# }

# ACL Plugin - Restrict access by consumer groups
resource "konnect_gateway_plugin_acl" "premium_only" {
  enabled = var.enable_acl

  config = {
    allow              = ["premium-users"]
    deny               = null
    hide_groups_header = true
  }

  route = {
    id = konnect_gateway_route.get_anything.id
  }

  control_plane_id = local.control_plane_id
}

# Request Transformer Plugin
resource "konnect_gateway_plugin_request_transformer" "transform_request" {
  enabled = var.enable_request_transformer

  config = {
    add = {
      headers     = ["X-Transformed:true", "X-Kong-Request-ID:$(request_id)"]
      querystring = ["source:kong"]
    }
    remove = {
      headers = ["X-Internal-Header"]
    }
    replace = {
      headers = []
    }
  }

  service = {
    id = konnect_gateway_service.httpbin_api.id
  }

  control_plane_id = local.control_plane_id
}

# Response Transformer Plugin
resource "konnect_gateway_plugin_response_transformer" "transform_response" {
  enabled = var.enable_response_transformer

  config = {
    add = {
      headers = ["X-Response-Transformed:true", "X-Kong-Proxy-Latency:$(latencies.proxy)"]
      json    = []
    }
    remove = {
      headers = ["X-Internal-Response-Header"]
    }
  }

  service = {
    id = konnect_gateway_service.httpbin_api.id
  }

  control_plane_id = local.control_plane_id
}

# IP Restriction Plugin
resource "konnect_gateway_plugin_ip_restriction" "ip_whitelist" {
  enabled = var.enable_ip_restriction

  config = {
    allow   = var.allowed_ips
    deny    = []
    status  = 403
    message = "Your IP address is not allowed to access this resource"
  }

  route = {
    id = konnect_gateway_route.post_anything.id
  }

  control_plane_id = local.control_plane_id
}

# Proxy Cache Plugin
resource "konnect_gateway_plugin_proxy_cache" "api_cache" {
  enabled = var.enable_proxy_cache

  config = {
    cache_ttl      = 300
    content_type   = ["application/json", "text/plain"]
    request_method = ["GET", "HEAD"]
    response_code  = [200, 301, 302, 404]
    strategy       = "memory"
    memory = {
      dictionary_name = "kong_db_cache"
    }
    cache_control     = false
    storage_ttl       = null
    vary_headers      = null
    vary_query_params = null
  }

  route = {
    id = konnect_gateway_route.get_anything.id
  }

  control_plane_id = local.control_plane_id
}

# Bot Detection Plugin
resource "konnect_gateway_plugin_bot_detection" "bot_protection" {
  enabled = var.enable_bot_detection

  config = {
    allow = []
    deny  = []
  }

  service = {
    id = konnect_gateway_service.httpbin_api.id
  }

  control_plane_id = local.control_plane_id
}

# Request Size Limiting Plugin
resource "konnect_gateway_plugin_request_size_limiting" "size_limit" {
  enabled = var.enable_request_size_limiting

  config = {
    allowed_payload_size   = 10
    size_unit              = "megabytes"
    require_content_length = false
  }

  service = {
    id = konnect_gateway_service.httpbin_api.id
  }

  control_plane_id = local.control_plane_id
}

# HTTP Log Plugin - Send logs to external service
resource "konnect_gateway_plugin_http_log" "external_logging" {
  count   = var.enable_http_log ? 1 : 0
  enabled = true

  config = {
    http_endpoint = var.http_log_endpoint
    method        = "POST"
    timeout       = 10000
    keepalive     = 60000
    content_type  = "application/json"
    flush_timeout = 2
    retry_count   = 10
  }

  service = {
    id = konnect_gateway_service.httpbin_api.id
  }

  control_plane_id = local.control_plane_id
}

# Correlation ID Plugin
resource "konnect_gateway_plugin_correlation_id" "request_tracking" {
  enabled = var.enable_correlation_id

  config = {
    header_name     = "X-Correlation-ID"
    generator       = "uuid"
    echo_downstream = true
  }

  service = {
    id = konnect_gateway_service.httpbin_api.id
  }

  control_plane_id = local.control_plane_id
}

# Request Termination Plugin - For maintenance mode
resource "konnect_gateway_plugin_request_termination" "maintenance_mode" {
  enabled = var.maintenance_mode

  config = {
    status_code  = 503
    content_type = "application/json"
    body = jsonencode({
      error   = "Service under maintenance"
      message = "Service temporarily unavailable for maintenance"
    })
  }

  service = {
    id = konnect_gateway_service.httpbin_api.id
  }

  control_plane_id = local.control_plane_id
}

# Datadog Plugin
resource "konnect_gateway_plugin_datadog" "datadog_monitoring" {
  count   = var.enable_datadog ? 1 : 0
  enabled = true

  config = {
    host = var.datadog_host
    port = 8125
    metrics = [
      {
        name        = "request_count"
        stat_type   = "counter"
        sample_rate = 1
      },
      {
        name        = "latency"
        stat_type   = "timer"
        sample_rate = 1
      }
    ]
    prefix = "kong"
  }

  service = {
    id = konnect_gateway_service.httpbin_api.id
  }

  control_plane_id = local.control_plane_id
}
