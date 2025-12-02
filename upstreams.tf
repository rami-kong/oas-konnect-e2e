# HTTPBin Upstream
resource "konnect_gateway_upstream" "httpbin_upstream" {
  control_plane_id = konnect_gateway_control_plane.terraform_cp.id
  name             = "httpbin-upstream"
  algorithm        = "round-robin"
  slots            = 10000

  tags = ["production", "load-balancing"]

  healthchecks = {
    active = {
      concurrency = 10
      healthy = {
        http_statuses = [200, 302]
        interval      = 5
        successes     = 2
      }
      http_path                = "/status/200"
      https_verify_certificate = true
      timeout                  = 1
      type                     = "http"
      unhealthy = {
        http_failures = 3
        http_statuses = [429, 500, 503]
        interval      = 5
        tcp_failures  = 0
        timeouts      = 3
      }
    }
    passive = {
      healthy = {
        http_statuses = [200, 201, 202, 203, 204, 205, 206, 207, 208, 226,
        300, 301, 302, 303, 304, 305, 306, 307, 308]
        successes = 5
      }
      type = "http"
      unhealthy = {
        http_failures = 5
        http_statuses = [429, 500, 503]
        tcp_failures  = 0
        timeouts      = 2
      }
    }
  }
}

# TARGETS COMMENTED OUT - Already exist, causing "target (type: unique) constraint failed"
/*
resource "konnect_gateway_target" "httpbin_target_1" {
  control_plane_id = konnect_gateway_control_plane.terraform_cp.id
  upstream_id      = konnect_gateway_upstream.httpbin_upstream.id
  target           = "httpbin.org:443"
  weight           = 100
  tags             = ["primary"]
}

resource "konnect_gateway_target" "httpbin_target_2" {
  control_plane_id = konnect_gateway_control_plane.terraform_cp.id
  upstream_id      = konnect_gateway_upstream.httpbin_upstream.id
  target           = "httpbin.org:443"
  weight           = 100
  tags             = ["secondary"]
}
*/

# Canary Deployment Upstream
resource "konnect_gateway_upstream" "canary_upstream" {
  control_plane_id = konnect_gateway_control_plane.terraform_cp.id
  name             = "canary-upstream"
  algorithm        = "consistent-hashing"
  hash_on          = "header"
  hash_on_header   = "X-User-ID"
  hash_fallback    = "ip"
  slots            = 10000

  tags = ["canary", "deployment"]
}

# CANARY TARGETS COMMENTED OUT - Already exist, causing "target (type: unique) constraint failed"
/*
resource "konnect_gateway_target" "canary_production" {
  control_plane_id = konnect_gateway_control_plane.terraform_cp.id
  upstream_id      = konnect_gateway_upstream.canary_upstream.id
  target           = "httpbin.org:443"
  weight           = 90
  tags             = ["production", "v1"]
}

resource "konnect_gateway_target" "canary_new" {
  control_plane_id = konnect_gateway_control_plane.terraform_cp.id
  upstream_id      = konnect_gateway_upstream.canary_upstream.id
  target           = "httpbin.org:443"
  weight           = 10
  tags             = ["canary", "v2"]
}
*/