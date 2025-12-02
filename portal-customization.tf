# ============================================================================
# PORTAL APPEARANCE CUSTOMIZATION
# ============================================================================

# Portal Appearance Settings
# Note: Commented out - arguments not supported in current provider version
# Configure appearance through Konnect UI instead
# resource "konnect_portal_appearance" "custom_theme" {
#   count     = var.enable_portal_customization ? 1 : 0
#   portal_id = konnect_portal.terraform_portal.id
# }

# ============================================================================
# PORTAL PRODUCT VERSIONS (for API versioning in portal)
# ============================================================================

# Note: Product version resources commented out - not supported in provider v3.1.0
# Use konnect_api_publication for publishing APIs instead

# # Product Version for HTTPBin API v1
# resource "konnect_portal_product_version" "httpbin_v1" {
#   count              = var.enable_product_versions ? 1 : 0
#   portal_id          = konnect_portal.terraform_portal.id
#   product_version_id = konnect_api.httpbin_api.id
#   
#   publish_status                   = "published"
#   deprecated                       = false
#   application_registration_enabled = true
#   auto_approve_registration        = true
#   auth_strategy_ids                = []
# }

# # Product Version for HTTPBin API v2 (if you create a v2)
# resource "konnect_portal_product_version" "httpbin_v2" {
#   count              = var.enable_httpbin_v2 ? 1 : 0
#   portal_id          = konnect_portal.terraform_portal.id
#   product_version_id = var.httpbin_v2_api_id
#   
#   publish_status                   = "published"
#   deprecated                       = false
#   application_registration_enabled = true
#   auto_approve_registration        = true
#   auth_strategy_ids                = []
# }

# # Deprecate old version (example)
# resource "konnect_portal_product_version" "httpbin_v1_deprecated" {
#   count              = var.deprecate_httpbin_v1 ? 1 : 0
#   portal_id          = konnect_portal.terraform_portal.id
#   product_version_id = konnect_api.httpbin_api.id
#   
#   publish_status                   = "published"
#   deprecated                       = true
#   application_registration_enabled = true
#   auto_approve_registration        = true
#   auth_strategy_ids                = []
# }

# ============================================================================
# DEVELOPER TEAMS (Portal-level teams, different from RBAC teams)
# ============================================================================

# Developer team in portal (Not supported in provider v3.1.0)
# Manage developer teams via Konnect UI
# resource "konnect_portal_developer_team" "internal_developers" {
#   count       = var.enable_developer_teams ? 1 : 0
#   portal_id   = konnect_portal.terraform_portal.id
#   name        = "Internal Developers"
#   description = "Team for internal API consumers"
# }

# resource "konnect_portal_developer_team" "partner_developers" {
#   count       = var.enable_developer_teams ? 1 : 0
#   portal_id   = konnect_portal.terraform_portal.id
#   name        = "Partner Developers"
#   description = "Team for partner integrations"
# }

# ============================================================================
# API CATALOG TAGS & CATEGORIES
# ============================================================================

# Note: Tags are applied directly to APIs via labels
# Here we document the tagging strategy

locals {
  api_tags = {
    # By API Type
    rest_apis    = ["rest", "api"]
    graphql_apis = ["graphql", "api"]
    grpc_apis    = ["grpc", "api"]

    # By Domain
    payment_apis  = ["payment", "finance"]
    identity_apis = ["identity", "auth"]
    data_apis     = ["data", "analytics"]

    # By Lifecycle
    alpha_apis      = ["alpha", "experimental"]
    beta_apis       = ["beta", "preview"]
    stable_apis     = ["stable", "production"]
    deprecated_apis = ["deprecated", "legacy"]

    # By Access Level
    public_apis   = ["public", "external"]
    internal_apis = ["internal", "private"]
    partner_apis  = ["partner", "b2b"]
  }
}

# Example: Additional API with rich tagging
resource "konnect_api" "payment_api" {
  count       = var.enable_payment_api_example ? 1 : 0
  name        = "Payment API"
  version     = "v2.1.0"
  description = "Secure payment processing API with PCI compliance"

  labels = {
    api_type    = "rest"
    domain      = "payment"
    lifecycle   = "production"
    access      = "partner"
    compliance  = "pci-dss"
    sla         = "tier-1"
    team        = "payments"
    cost_center = "finance"
  }
}

# ============================================================================
# PORTAL NOTIFICATIONS & ANNOUNCEMENTS
# ============================================================================

# Portal page for announcements
resource "konnect_portal_page" "announcements" {
  portal_id   = konnect_portal.terraform_portal.id
  title       = "Announcements"
  slug        = "announcements"
  status      = "published"
  visibility  = "public"
  description = "Latest updates and announcements"
  content     = <<-EOT
    # Announcements
    
    ## December 2025
    
    ### 🚀 New Features
    - **HTTPBin API v1.0.0** now generally available
    - Enhanced rate limiting with consumer groups
    - New developer portal with interactive documentation
    
    ### 🔧 Improvements
    - Faster API response times (30% improvement)
    - Enhanced error messages
    - Better API documentation search
    
    ### 📅 Upcoming
    - **January 2026**: GraphQL API beta release
    - **February 2026**: Webhook support for all APIs
    - **March 2026**: Enhanced analytics dashboard
    
    ## Previous Announcements
    
    ### November 2025
    - Portal redesign launched
    - New authentication methods available
    - Improved sandbox environment
    
    ### October 2025
    - Rate limit increases for premium tier
    - New code examples in multiple languages
    - API monitoring dashboard beta
    
    ---
    
    Subscribe to our [RSS feed](/announcements.rss) for updates.
  EOT
}

# Portal page for service status
resource "konnect_portal_page" "status" {
  portal_id   = konnect_portal.terraform_portal.id
  title       = "Service Status"
  slug        = "status"
  status      = "published"
  visibility  = "public"
  description = "Current status of all APIs and services"
  content     = <<-EOT
    # Service Status
    
    ## Current Status: All Systems Operational ✅
    
    Last updated: ${timestamp()}
    
    ### API Services
    
    | Service | Status | Uptime | Response Time |
    |---------|--------|--------|---------------|
    | HTTPBin API | 🟢 Operational | 99.99% | 45ms |
    | Portal | 🟢 Operational | 99.95% | 120ms |
    | Authentication | 🟢 Operational | 99.99% | 15ms |
    
    ### Regional Status
    
    | Region | Status | Notes |
    |--------|--------|-------|
    | North America | 🟢 Operational | - |
    | Europe | 🟢 Operational | - |
    | Asia Pacific | 🟢 Operational | - |
    | Australia | 🟢 Operational | - |
    
    ## Scheduled Maintenance
    
    No scheduled maintenance at this time.
    
    ## Recent Incidents
    
    No incidents in the last 30 days.
    
    ---
    
    For real-time status updates, visit our [status page](https://status.example.com)
  EOT
}

# Terms of Service page
resource "konnect_portal_page" "terms" {
  portal_id   = konnect_portal.terraform_portal.id
  title       = "Terms of Service"
  slug        = "terms"
  status      = "published"
  visibility  = "public"
  description = "API Terms of Service"
  content     = var.portal_terms_of_service
}

# Privacy Policy page
resource "konnect_portal_page" "privacy" {
  portal_id   = konnect_portal.terraform_portal.id
  title       = "Privacy Policy"
  slug        = "privacy"
  status      = "published"
  visibility  = "public"
  description = "Privacy Policy"
  content     = var.portal_privacy_policy
}
