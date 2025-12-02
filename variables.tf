# Core Configuration
variable "konnect_token" {
  description = "Kong Konnect Personal Access Token (set via KONNECT_TOKEN env var)"
  type        = string
  sensitive   = true
}

variable "konnect_server_url" {
  description = "Kong Konnect API server URL"
  type        = string
  default     = "https://us.api.konghq.com"
}

variable "konnect_region" {
  description = "Kong Konnect region (us, eu, au)"
  type        = string
  default     = "us"
}

variable "aws_deployment" {
  description = "Enable AWS-specific optimizations and features"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string
  default     = "demo"
}

# Control Plane Configuration
variable "control_plane_name" {
  description = "Name of the control plane"
  type        = string
  default     = "Terraform Demo Control Plane"
}

variable "control_plane_description" {
  description = "Description of the control plane"
  type        = string
  default     = "Control plane for API catalog demo managed by Terraform"
}

# Portal Configuration
variable "portal_name" {
  description = "Name of the developer portal"
  type        = string
  default     = "API Developer Portal"
}

variable "portal_force_destroy" {
  description = "Allow portal to be destroyed even if it has content"
  type        = string
  default     = "true"
}

variable "default_api_visibility" {
  description = "Default visibility for APIs (public, internal, private)"
  type        = string
  default     = "public"
}

variable "auto_approve_developers" {
  description = "Automatically approve developer registrations"
  type        = bool
  default     = true
}

variable "auto_approve_applications" {
  description = "Automatically approve application registrations"
  type        = bool
  default     = true
}

variable "portal_auth_enabled" {
  description = "Enable authentication for the portal"
  type        = bool
  default     = true
}

variable "portal_rbac_enabled" {
  description = "Enable RBAC for the portal"
  type        = bool
  default     = false
}

variable "portal_custom_domain" {
  description = "Custom domain for the portal"
  type        = string
  default     = null
}

# API Catalog Configuration
variable "api_visibility" {
  description = "Visibility of published APIs (public, internal, private)"
  type        = string
  default     = "public"
}

variable "auto_approve_api_registrations" {
  description = "Auto-approve API application registrations"
  type        = bool
  default     = true
}

variable "enable_app_registration" {
  description = "Enable application registration for APIs"
  type        = bool
  default     = true
}

variable "enable_second_api" {
  description = "Enable second example API"
  type        = bool
  default     = false
}

# Portal Customization
variable "enable_portal_customization" {
  description = "Enable portal appearance customization"
  type        = bool
  default     = false
}

variable "portal_primary_color" {
  description = "Primary color for portal theme"
  type        = string
  default     = "#1155CC"
}

variable "portal_secondary_color" {
  description = "Secondary color for portal theme"
  type        = string
  default     = "#FF6600"
}

variable "portal_text_color" {
  description = "Text color for portal theme"
  type        = string
  default     = "#333333"
}

variable "portal_button_color" {
  description = "Button color for portal theme"
  type        = string
  default     = "#1155CC"
}

variable "portal_custom_css" {
  description = "Custom CSS for portal"
  type        = string
  default     = ""
}

variable "portal_logo_url" {
  description = "URL to portal logo"
  type        = string
  default     = null
}

variable "portal_favicon_url" {
  description = "URL to portal favicon"
  type        = string
  default     = null
}

variable "portal_catalog_cover_url" {
  description = "URL to portal catalog cover image"
  type        = string
  default     = null
}

variable "portal_terms_of_service" {
  description = "Terms of Service content"
  type        = string
  default     = "# Terms of Service\n\nPlease add your terms of service here."
}

variable "portal_privacy_policy" {
  description = "Privacy Policy content"
  type        = string
  default     = "# Privacy Policy\n\nPlease add your privacy policy here."
}

# Product Versions
variable "enable_product_versions" {
  description = "Enable product version management"
  type        = bool
  default     = false
}

variable "enable_httpbin_v2" {
  description = "Enable HTTPBin API v2"
  type        = bool
  default     = false
}

variable "httpbin_v2_api_id" {
  description = "API ID for HTTPBin v2"
  type        = string
  default     = ""
}

variable "httpbin_v2_service_id" {
  description = "Service ID for HTTPBin v2"
  type        = string
  default     = ""
}

variable "deprecate_httpbin_v1" {
  description = "Mark HTTPBin v1 as deprecated"
  type        = bool
  default     = false
}

variable "httpbin_v1_sunset_date" {
  description = "Sunset date for HTTPBin v1"
  type        = string
  default     = "2026-12-31"
}

# Developer Teams
variable "enable_developer_teams" {
  description = "Enable developer teams in portal"
  type        = bool
  default     = false
}

# Example APIs
variable "enable_payment_api_example" {
  description = "Enable payment API example"
  type        = bool
  default     = false
}

# Team Management
variable "enable_team_memberships" {
  description = "Enable team membership creation"
  type        = bool
  default     = false
}

variable "platform_lead_user_id" {
  description = "User ID for platform team lead"
  type        = string
  default     = ""
}

variable "api_developer_user_id" {
  description = "User ID for API developer"
  type        = string
  default     = ""
}

# Consumer Credentials
variable "api_key_credential" {
  description = "API key for key-auth consumer"
  type        = string
  sensitive   = true
  default     = null
}

variable "basic_auth_username" {
  description = "Username for basic auth"
  type        = string
  default     = "basic-user"
}

variable "basic_auth_password" {
  description = "Password for basic auth"
  type        = string
  sensitive   = true
  default     = "secure-password-123"
}

variable "jwt_secret" {
  description = "JWT secret for signing"
  type        = string
  sensitive   = true
  default     = null
}

variable "hmac_secret" {
  description = "HMAC secret"
  type        = string
  sensitive   = true
  default     = null
}

variable "oauth2_client_id" {
  description = "OAuth2 client ID"
  type        = string
  default     = null
}

variable "oauth2_client_secret" {
  description = "OAuth2 client secret"
  type        = string
  sensitive   = true
  default     = null
}

variable "oauth2_redirect_uris" {
  description = "OAuth2 redirect URIs"
  type        = list(string)
  default     = ["https://example.com/callback"]
}

# Plugin Configuration
variable "enable_key_auth" {
  description = "Enable key authentication plugin"
  type        = bool
  default     = false
}

variable "enable_basic_auth" {
  description = "Enable basic authentication plugin"
  type        = bool
  default     = false
}

variable "enable_jwt_auth" {
  description = "Enable JWT authentication plugin"
  type        = bool
  default     = false
}

variable "enable_oauth2" {
  description = "Enable OAuth2 plugin"
  type        = bool
  default     = false
}

variable "enable_acl" {
  description = "Enable ACL plugin"
  type        = bool
  default     = false
}

variable "enable_request_transformer" {
  description = "Enable request transformer plugin"
  type        = bool
  default     = true
}

variable "enable_response_transformer" {
  description = "Enable response transformer plugin"
  type        = bool
  default     = true
}

variable "enable_ip_restriction" {
  description = "Enable IP restriction plugin"
  type        = bool
  default     = false
}

variable "allowed_ips" {
  description = "List of allowed IP addresses"
  type        = list(string)
  default     = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

variable "enable_proxy_cache" {
  description = "Enable proxy cache plugin"
  type        = bool
  default     = true
}

variable "enable_bot_detection" {
  description = "Enable bot detection plugin"
  type        = bool
  default     = false
}

variable "enable_request_size_limiting" {
  description = "Enable request size limiting plugin"
  type        = bool
  default     = true
}

variable "enable_http_log" {
  description = "Enable HTTP log plugin"
  type        = bool
  default     = false
}

variable "http_log_endpoint" {
  description = "HTTP endpoint for logging"
  type        = string
  default     = "https://logs.example.com/kong"
}

variable "enable_correlation_id" {
  description = "Enable correlation ID plugin"
  type        = bool
  default     = true
}

variable "maintenance_mode" {
  description = "Enable maintenance mode (request termination)"
  type        = bool
  default     = false
}

variable "enable_datadog" {
  description = "Enable Datadog plugin"
  type        = bool
  default     = false
}

variable "datadog_host" {
  description = "Datadog agent host"
  type        = string
  default     = "localhost"
}

# Vault Configuration
variable "enable_aws_vault" {
  description = "Enable AWS Secrets Manager vault"
  type        = bool
  default     = true
}

variable "aws_region" {
  description = "AWS region for Secrets Manager and other AWS services"
  type        = string
  default     = "us-east-1"
}

variable "aws_secondary_region" {
  description = "Secondary AWS region for multi-region setup"
  type        = string
  default     = "us-west-2"
}

variable "enable_env_vault" {
  description = "Enable environment variables vault"
  type        = bool
  default     = false
}

variable "enable_gcp_vault" {
  description = "Enable GCP Secret Manager vault"
  type        = bool
  default     = false
}

variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
  default     = ""
}

variable "enable_hashicorp_vault" {
  description = "Enable HashiCorp Vault integration"
  type        = bool
  default     = false
}

variable "vault_host" {
  description = "HashiCorp Vault host"
  type        = string
  default     = "vault.example.com"
}

variable "vault_port" {
  description = "HashiCorp Vault port"
  type        = number
  default     = 8200
}

variable "vault_token" {
  description = "HashiCorp Vault token"
  type        = string
  sensitive   = true
  default     = null
}

variable "vault_namespace" {
  description = "HashiCorp Vault namespace"
  type        = string
  default     = ""
}

variable "enable_azure_vault" {
  description = "Enable Azure Key Vault integration"
  type        = bool
  default     = false
}

variable "azure_vault_uri" {
  description = "Azure Key Vault URI"
  type        = string
  default     = ""
}

variable "azure_client_id" {
  description = "Azure client ID"
  type        = string
  default     = ""
}

variable "azure_client_secret" {
  description = "Azure client secret"
  type        = string
  sensitive   = true
  default     = null
}

variable "azure_tenant_id" {
  description = "Azure tenant ID"
  type        = string
  default     = ""
}

# Certificate Configuration
variable "enable_mtls" {
  description = "Enable mTLS with CA certificates"
  type        = bool
  default     = false
}

variable "ca_certificate" {
  description = "Root CA certificate"
  type        = string
  sensitive   = true
  default     = null
}

variable "client_ca_certificate" {
  description = "Client CA certificate"
  type        = string
  sensitive   = true
  default     = null
}

variable "enable_custom_domain" {
  description = "Enable custom domain with TLS certificate"
  type        = bool
  default     = false
}

variable "custom_domain" {
  description = "Custom domain name"
  type        = string
  default     = "api.example.com"
}

variable "server_certificate" {
  description = "Server TLS certificate"
  type        = string
  sensitive   = true
  default     = null
}

variable "server_private_key" {
  description = "Server TLS private key"
  type        = string
  sensitive   = true
  default     = null
}

variable "enable_custom_plugin" {
  description = "Enable custom plugin schema"
  type        = bool
  default     = false
}

variable "custom_plugin_lua_schema" {
  description = "Lua schema for custom plugin"
  type        = string
  default     = ""
}

variable "enable_key_management" {
  description = "Enable key and key set management"
  type        = bool
  default     = false
}

variable "jwk_key" {
  description = "JWK key for signing"
  type        = string
  default     = ""
}

variable "signing_private_key" {
  description = "Private key for signing"
  type        = string
  sensitive   = true
  default     = null
}

variable "signing_public_key" {
  description = "Public key for verification"
  type        = string
  default     = null
}

# Data Plane Configuration
variable "enable_dp_client_cert" {
  description = "Enable data plane client certificate"
  type        = bool
  default     = false
}

variable "dp_client_certificate" {
  description = "Data plane client certificate"
  type        = string
  sensitive   = true
  default     = null
}

variable "enable_system_account" {
  description = "Enable system account for data plane"
  type        = bool
  default     = false
}

variable "system_account_token_expiry" {
  description = "System account token expiry timestamp"
  type        = string
  default     = "2026-12-31T23:59:59Z"
}

variable "enable_cloud_gateway" {
  description = "Enable cloud gateway configuration"
  type        = bool
  default     = false
}

variable "control_plane_geo" {
  description = "Control plane geographic location"
  type        = string
  default     = "au"
}

variable "cloud_gateway_provider" {
  description = "Cloud gateway provider (aws, azure, gcp)"
  type        = string
  default     = "aws"
}

variable "cloud_gateway_version" {
  description = "Kong Gateway version for cloud gateway"
  type        = string
  default     = "3.8"
}

variable "cloud_gateway_region" {
  description = "Cloud gateway region"
  type        = string
  default     = "us-east-1"
}

variable "cloud_gateway_availability_zones" {
  description = "AWS availability zones for high availability"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "cloud_gateway_autoscale_kind" {
  description = "Autoscale configuration kind"
  type        = string
  default     = "autopilot"
}

variable "cloud_gateway_base_rps" {
  description = "Base requests per second for autoscaling"
  type        = number
  default     = 100
}

variable "cloud_gateway_max_rps" {
  description = "Maximum requests per second for autoscaling"
  type        = number
  default     = 10000
}

variable "dataplane_group_id" {
  description = "Dataplane group ID for network configuration"
  type        = string
  default     = ""
}

variable "egress_ip_addresses" {
  description = "Egress IP addresses"
  type        = list(string)
  default     = []
}

variable "firewall_allowed_ips" {
  description = "Firewall allowed IP addresses"
  type        = list(string)
  default     = []
}

variable "enable_cloud_gateway_custom_domain" {
  description = "Enable custom domain for cloud gateway"
  type        = bool
  default     = false
}

variable "cloud_gateway_custom_domain" {
  description = "Custom domain for cloud gateway"
  type        = string
  default     = "api.example.com"
}

variable "enable_transit_gateway" {
  description = "Enable transit gateway attachment"
  type        = bool
  default     = false
}

variable "aws_ram_share_arn" {
  description = "AWS RAM share ARN"
  type        = string
  default     = ""
}

variable "aws_transit_gateway_id" {
  description = "AWS Transit Gateway ID"
  type        = string
  default     = ""
}

variable "transit_gateway_cidrs" {
  description = "Transit gateway CIDR blocks"
  type        = list(string)
  default     = []
}

variable "enable_provider_account" {
  description = "Enable cloud provider account configuration"
  type        = bool
  default     = false
}

variable "cloud_provider_kind" {
  description = "Cloud provider kind (aws, azure)"
  type        = string
  default     = "aws"
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
  default     = ""
}

variable "aws_arn" {
  description = "AWS ARN"
  type        = string
  default     = ""
}

variable "aws_external_id" {
  description = "AWS external ID"
  type        = string
  default     = ""
}

variable "konnect_account_id" {
  description = "Konnect account ID"
  type        = string
  default     = ""
}

variable "azure_subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = ""
}

# ============================================================================
# AWS-SPECIFIC CONFIGURATION
# ============================================================================

variable "aws_cost_center" {
  description = "AWS cost center tag"
  type        = string
  default     = "engineering"
}

variable "aws_owner_email" {
  description = "AWS resource owner email"
  type        = string
  default     = ""
}

variable "aws_billing_code" {
  description = "AWS billing code for cost allocation"
  type        = string
  default     = ""
}

# AWS Multi-Region
variable "enable_aws_multi_region" {
  description = "Enable multi-region AWS deployment"
  type        = bool
  default     = false
}

# AWS CloudWatch
variable "enable_aws_cloudwatch" {
  description = "Enable AWS CloudWatch logging"
  type        = bool
  default     = false
}

# AWS Lambda
variable "enable_aws_lambda" {
  description = "Enable AWS Lambda integration"
  type        = bool
  default     = false
}

variable "aws_lambda_function_name" {
  description = "AWS Lambda function name"
  type        = string
  default     = ""
}

variable "aws_lambda_invocation_type" {
  description = "Lambda invocation type (RequestResponse or Event)"
  type        = string
  default     = "RequestResponse"
}

variable "aws_lambda_role_arn" {
  description = "IAM role ARN for Lambda execution"
  type        = string
  default     = ""
}

variable "aws_lambda_route_id" {
  description = "Route ID for Lambda integration"
  type        = string
  default     = ""
}

# AWS Transit Gateway
variable "enable_aws_transit_gateway" {
  description = "Enable AWS Transit Gateway integration"
  type        = bool
  default     = false
}

variable "aws_vpc_cidrs" {
  description = "AWS VPC CIDR blocks"
  type        = list(string)
  default     = []
}

variable "aws_egress_ips" {
  description = "AWS egress IP addresses"
  type        = list(string)
  default     = []
}

variable "additional_allowed_ips" {
  description = "Additional allowed IP addresses"
  type        = list(string)
  default     = []
}

# AWS Provider Account
variable "enable_aws_provider_account" {
  description = "Enable AWS provider account integration"
  type        = bool
  default     = false
}

variable "aws_iam_role_arn" {
  description = "AWS IAM role ARN for cross-account access"
  type        = string
  default     = ""
}

# AWS Route 53 & Custom Domain
variable "enable_aws_custom_domain" {
  description = "Enable custom domain with Route 53"
  type        = bool
  default     = false
}

variable "aws_custom_domain" {
  description = "Custom domain for AWS deployment"
  type        = string
  default     = ""
}

# AWS ACM (Certificate Manager)
variable "enable_aws_acm_cert" {
  description = "Enable AWS ACM certificate"
  type        = bool
  default     = false
}

variable "aws_acm_certificate" {
  description = "AWS ACM certificate content"
  type        = string
  sensitive   = true
  default     = null
}

variable "aws_acm_private_key" {
  description = "AWS ACM private key"
  type        = string
  sensitive   = true
  default     = null
}

# AWS ElastiCache
variable "enable_aws_elasticache" {
  description = "Enable AWS ElastiCache for rate limiting"
  type        = bool
  default     = false
}

variable "aws_elasticache_endpoint" {
  description = "AWS ElastiCache Redis endpoint"
  type        = string
  default     = ""
}

variable "aws_elasticache_port" {
  description = "AWS ElastiCache Redis port"
  type        = number
  default     = 6379
}

variable "aws_elasticache_password" {
  description = "AWS ElastiCache Redis password"
  type        = string
  sensitive   = true
  default     = null
}

variable "aws_elasticache_ssl" {
  description = "Enable SSL for ElastiCache"
  type        = bool
  default     = true
}

# AWS RDS
variable "enable_aws_rds_oauth" {
  description = "Enable AWS RDS for OAuth2 token storage"
  type        = bool
  default     = false
}

variable "aws_rds_endpoint" {
  description = "AWS RDS endpoint"
  type        = string
  default     = ""
}

variable "aws_rds_port" {
  description = "AWS RDS port"
  type        = number
  default     = 5432
}

variable "aws_rds_username" {
  description = "AWS RDS username"
  type        = string
  default     = ""
}

variable "aws_rds_password" {
  description = "AWS RDS password"
  type        = string
  sensitive   = true
  default     = null
}

variable "aws_rds_database" {
  description = "AWS RDS database name"
  type        = string
  default     = "kong_oauth2"
}

# AWS SigV4 Authentication
variable "enable_aws_sigv4_auth" {
  description = "Enable AWS SigV4 authentication"
  type        = bool
  default     = false
}

variable "aws_auth_lambda_function" {
  description = "Lambda function for AWS authentication"
  type        = string
  default     = ""
}

variable "aws_auth_role_arn" {
  description = "IAM role ARN for authentication"
  type        = string
  default     = ""
}

# AWS Cognito
variable "enable_aws_cognito" {
  description = "Enable AWS Cognito integration"
  type        = bool
  default     = false
}

variable "aws_cognito_user_pool_id" {
  description = "AWS Cognito User Pool ID"
  type        = string
  default     = ""
}

variable "aws_cognito_region" {
  description = "AWS Cognito region"
  type        = string
  default     = ""
}

# AWS SSM Parameter Store
variable "enable_aws_ssm" {
  description = "Enable AWS Systems Manager Parameter Store"
  type        = bool
  default     = false
}

# AWS Datadog
variable "enable_aws_datadog" {
  description = "Enable Datadog for AWS monitoring"
  type        = bool
  default     = false
}

variable "aws_datadog_agent_host" {
  description = "Datadog agent host for AWS"
  type        = string
  default     = "localhost"
}

variable "oauth2_scopes" {
  description = "OAuth2 scopes"
  type        = list(string)
  default     = ["email", "profile", "openid"]
}