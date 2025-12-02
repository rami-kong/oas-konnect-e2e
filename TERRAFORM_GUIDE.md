# Kong Konnect Terraform - Enhanced Configuration

This Terraform configuration demonstrates comprehensive Kong Konnect scenarios and functionality based on the official provider documentation.

## Features

### Core Infrastructure
- **Control Plane**: Gateway control plane with cluster configuration
- **Dev Portal**: Developer portal with authentication and RBAC
- **API Catalog**: API management with OpenAPI specifications and documentation
- **Portal Customization**: Theme, branding, custom pages, and appearance
- **Portal Pages**: 9 comprehensive pages (Home, Getting Started, API Reference, Best Practices, FAQ, Status, Announcements, Terms, Privacy)

### Gateway Configuration

#### Services & Routes
- HTTPBin API service with multiple routes
- Load-balanced service with upstream configuration
- Route-level configuration for different HTTP methods

#### Upstreams & Load Balancing
- Round-robin load balancing
- Active and passive health checks
- Canary deployment with consistent hashing
- Multiple targets per upstream

### Authentication & Authorization

#### Consumers & Credentials
- **API Key Authentication**: Key-auth consumer with API keys
- **Basic Authentication**: Username/password authentication
- **JWT Authentication**: JSON Web Token support
- **HMAC Authentication**: HMAC signature verification
- **OAuth2**: OAuth2 application credentials
- **ACL Groups**: Access control lists for premium users
- **Consumer Groups**: Group-based rate limiting

### Plugins (20+ Plugin Types)

#### Security Plugins
- Key Authentication
- Basic Authentication
- JWT Authentication
- OAuth2
- ACL (Access Control List)
- IP Restriction
- Bot Detection
- HMAC Authentication

#### Traffic Control
- Rate Limiting Advanced
- Request Size Limiting
- Proxy Cache
- Request Termination (Maintenance Mode)

#### Transformation
- Request Transformer
- Response Transformer
- CORS

#### Observability
- HTTP Log
- Correlation ID
- Datadog Integration

### Team & Access Management
- **Teams**: Platform Engineering, API Developers, Operations
- **Team Roles**: Admin, Developer, Viewer roles
- **Team Memberships**: User assignment to teams
- **RBAC**: Role-based access control for control planes and portals

### Vault Integration
Support for multiple secret management backends:
- **AWS Secrets Manager**: AWS-based secret storage
- **Google Cloud Secret Manager**: GCP-based secret storage
- **Azure Key Vault**: Azure-based secret storage
- **HashiCorp Vault**: Enterprise secret management
- **Environment Variables**: Environment-based configuration

### Certificates & mTLS
- **CA Certificates**: Root and client CA certificates for mTLS
- **Server Certificates**: TLS certificates for custom domains
- **SNI Configuration**: Server Name Indication for multiple domains
- **Key Management**: JWT signing keys and key sets
- **Custom Plugin Schemas**: Support for custom plugins

### Data Plane Configuration
- **Client Certificates**: Data plane authentication certificates
- **System Accounts**: Service accounts for data plane authentication
- **Cloud Gateway**: Managed data plane configuration
- **Network Configuration**: Egress IPs and firewall rules
- **Custom Domains**: Custom domain configuration for cloud gateways
- **Transit Gateway**: AWS Transit Gateway integration
- **Provider Accounts**: Cloud provider account linking (AWS, Azure)

### Integration
- **GitLab Integration**: Integration with GitLab repositories
- **SwaggerHub Integration**: Import APIs from SwaggerHub

### Developer Portal & API Catalog (ENHANCED)
- **Portal Configuration**: Custom domain, authentication, RBAC, auto-approval settings
- **API Catalog**: Full API lifecycle management with versioning
- **API Documentation**: 4 comprehensive docs per API (Getting Started, Authentication, Examples, Changelog)
- **Portal Pages**: 9 pre-built pages including:
  - Home page with API catalog overview
  - Getting Started guide for developers
  - Complete API Reference documentation
  - Best Practices for API integration
  - Comprehensive FAQ
  - Service Status page
  - Announcements page
  - Terms of Service
  - Privacy Policy
- **Portal Customization**: Theme colors, custom CSS, logos, branding
- **Product Versioning**: API version management with deprecation notices
- **Developer Teams**: Portal-level teams for organizing developers
- **Multiple APIs**: Support for publishing multiple APIs to the portal
- **Application Registration**: Developer app registration with auto-approval options

## File Structure

```
.
├── main.tf                  # Provider configuration
├── variables.tf             # All input variables
├── outputs.tf               # Output values
├── control-plane.tf         # Control plane and portal
├── service.tf               # Services, routes, and catalog
├── portal-api.tf            # API catalog and documentation (ENHANCED)
├── portal-customization.tf  # Portal appearance and pages (NEW)
├── consumers.tf             # Consumers and credentials (NEW)
├── plugins.tf               # All gateway plugins (NEW)
├── teams.tf                 # Team and role management (NEW)
├── upstreams.tf             # Load balancing configuration (NEW)
├── vaults.tf                # Vault integrations (NEW)
├── certificates.tf          # Certificate and key management (NEW)
├── dataplane.tf             # Data plane configuration (NEW)
└── openapi.yaml             # OpenAPI specification
```

## Usage

### Prerequisites
1. Kong Konnect account with Personal Access Token
2. Terraform >= 1.0
3. Kong Konnect provider >= 3.1.0

### Basic Setup

1. **Initialize Terraform**:
```bash
terraform init
```

2. **Configure Variables**:
Create a `terraform.tfvars` file:
```hcl
konnect_pat        = "your-personal-access-token"
konnect_server_url = "https://au.api.konghq.com"
konnect_region     = "au"
```

3. **Plan and Apply**:
```bash
terraform plan
terraform apply
```

### Advanced Configuration

#### Enable Team Management
```hcl
enable_team_memberships = true
platform_lead_user_id   = "user-id-123"
api_developer_user_id   = "user-id-456"
```

#### Enable Authentication Plugins
```hcl
enable_key_auth   = true
enable_jwt_auth   = true
enable_basic_auth = true
enable_oauth2     = true
```

#### Configure Vault Integration
```hcl
# AWS Secrets Manager
enable_aws_vault = true
aws_region       = "us-east-1"

# HashiCorp Vault
enable_hashicorp_vault = true
vault_host             = "vault.example.com"
vault_token            = "hvs.xxx"
```

#### Configure Portal & API Catalog
```hcl
# Portal Settings
portal_name                = "My Company Developer Portal"
portal_auth_enabled        = true
portal_rbac_enabled        = true
auto_approve_developers    = false  # Require manual approval
auto_approve_applications  = false  # Require manual app approval
portal_custom_domain       = "developers.mycompany.com"

# API Catalog
api_visibility                 = "public"  # or "internal", "private"
enable_app_registration        = true
auto_approve_api_registrations = true
enable_second_api              = true  # Enable additional example API

# Portal Customization
enable_portal_customization = true
portal_primary_color        = "#1155CC"
portal_secondary_color      = "#FF6600"
portal_logo_url             = "https://cdn.example.com/logo.png"
portal_favicon_url          = "https://cdn.example.com/favicon.ico"
```

#### Configure Product Versioning
```hcl
enable_product_versions = true

# Deprecate old version
deprecate_httpbin_v1    = true
httpbin_v1_sunset_date  = "2026-12-31"

# Enable v2
enable_httpbin_v2       = true
httpbin_v2_api_id       = "api-id-here"
httpbin_v2_service_id   = "service-id-here"
```

#### Enable Developer Teams
```hcl
enable_developer_teams = true  # Creates portal-level dev teams
```

#### Enable mTLS
```hcl
enable_mtls            = true
ca_certificate         = file("certs/ca.crt")
client_ca_certificate  = file("certs/client-ca.crt")
```

#### Configure Custom Domain
```hcl
enable_custom_domain = true
custom_domain        = "api.example.com"
server_certificate   = file("certs/server.crt")
server_private_key   = file("certs/server.key")
```

#### Enable Cloud Gateway
```hcl
enable_cloud_gateway        = true
control_plane_geo           = "au"
cloud_gateway_provider      = "aws"
cloud_gateway_region        = "ap-southeast-2"
cloud_gateway_base_rps      = 100
cloud_gateway_max_rps       = 10000
```

#### IP Restriction
```hcl
enable_ip_restriction = true
allowed_ips          = ["10.0.0.0/8", "172.16.0.0/12"]
```

#### External Logging
```hcl
enable_http_log    = true
http_log_endpoint  = "https://logs.example.com/kong"
```

#### Monitoring
```hcl
enable_datadog = true
datadog_host   = "datadog-agent.example.com"
```

## Scenarios Covered

### 1. Basic API Gateway
- Service and route configuration
- CORS and rate limiting
- API catalog with OpenAPI spec

### 2. Multi-Auth Setup
- Multiple authentication methods
- Consumer management
- ACL-based access control

### 3. Enterprise Features
- Team-based RBAC
- Vault integration for secrets
- mTLS with CA certificates

### 4. High Availability
- Load balancing with health checks
- Multiple upstream targets
- Canary deployments

### 5. Cloud Integration
- Managed data planes
- Cloud provider accounts
- Transit gateway connectivity

### 6. Observability
- Request correlation
- External logging
- Monitoring integration

### 7. Advanced Traffic Management
- Request/response transformation
- Proxy caching
- IP whitelisting
- Bot detection

## Outputs

After applying, you'll get outputs including:
- Control plane ID and endpoint
- Portal ID and name
- Service and route IDs
- Consumer IDs
- Team IDs
- System account tokens (sensitive)
- Deployment summary

## Security Considerations

1. **Sensitive Variables**: Use environment variables or secure storage for:
   - `konnect_pat`
   - `*_password` variables
   - `*_secret` variables
   - Certificate private keys

2. **State File**: Ensure Terraform state is stored securely (e.g., S3 with encryption)

3. **Access Control**: Limit who can apply Terraform changes

4. **Secrets Management**: Use vault integration for production secrets

## Customization

### Adding More Plugins
Add to `plugins.tf`:
```hcl
resource "konnect_gateway_plugin_<plugin_name>" "example" {
  enabled = true
  config  = { ... }
  service = { id = konnect_gateway_service.httpbin_api.id }
  control_plane_id = local.control_plane_id
}
```

### Adding More Consumers
Add to `consumers.tf`:
```hcl
resource "konnect_gateway_consumer" "new_consumer" {
  username         = "new-user"
  control_plane_id = local.control_plane_id
}
```

### Adding More Services
Add to `service.tf`:
```hcl
resource "konnect_gateway_service" "new_service" {
  name     = "new-api"
  host     = "api.example.com"
  protocol = "https"
  control_plane_id = local.control_plane_id
}
```

## Troubleshooting

### Common Issues

1. **Authentication Errors**: Verify your PAT is valid and has correct permissions
2. **Resource Conflicts**: Ensure resource names are unique
3. **Plugin Configuration**: Check plugin schema in official docs
4. **Team Memberships**: Users must exist in Konnect before adding to teams

## References

- [Kong Konnect Provider Documentation](https://registry.terraform.io/providers/Kong/konnect/latest/docs)
- [Kong Gateway Documentation](https://docs.konghq.com/gateway/)
- [Kong Plugin Hub](https://docs.konghq.com/hub/)

## Version

- Terraform Provider: `kong/konnect` >= 3.1.0
- Terraform: >= 1.0

## License

See LICENSE file for details.
