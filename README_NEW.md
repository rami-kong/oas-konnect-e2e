# Kong Konnect Terraform - Enhanced Configuration 🚀

> **📢 Major Enhancement**: This repository has been significantly upgraded with 80+ Terraform resources covering all major Kong Konnect features. See [ENHANCEMENT_SUMMARY.md](./ENHANCEMENT_SUMMARY.md) for complete details.

## Overview

This repository demonstrates comprehensive Kong Konnect deployment using Terraform, from basic API gateway setup to enterprise-grade configurations with authentication, load balancing, vault integration, and more.

### Original Workflow (OpenAPI → Kong → Terraform)

The original workflow converts OpenAPI specs to Kong configuration, then to Terraform:

1. Takes an OpenAPI specification
2. Generates Kong configuration from the OpenAPI spec
3. Applies plugins (policies) to the Kong configuration
4. Converts the Kong configuration to Terraform
5. Deploys to Kong Konnect Control Plane
6. Publishes the API to Developer Portal

### Enhanced Capabilities

Now includes **80+ resources** across **17 Terraform files** covering:

- ✅ Multiple authentication methods (API Key, Basic, JWT, OAuth2, HMAC, ACL)
- ✅ 20+ gateway plugins (security, traffic control, transformation, observability)
- ✅ Load balancing with health checks and canary deployments
- ✅ Team-based RBAC with role assignments
- ✅ Vault integration (AWS, GCP, Azure, HashiCorp)
- ✅ Certificate management and mTLS
- ✅ Cloud gateway with managed data planes
- ✅ Full API catalog with developer portal

## 📚 Documentation

| Document | Description |
|----------|-------------|
| **[TERRAFORM_GUIDE.md](./TERRAFORM_GUIDE.md)** | 📖 Complete feature documentation and usage guide |
| **[SCENARIOS.md](./SCENARIOS.md)** | 🎯 13+ quick-start scenarios with examples |
| **[ENHANCEMENT_SUMMARY.md](./ENHANCEMENT_SUMMARY.md)** | 📊 Summary of all enhancements |
| **[terraform.tfvars.example](./terraform.tfvars.example)** | ⚙️ Configuration template |

## 🎯 Quick Start

### Option A: Basic Deployment (Simplest)

Perfect for first-time users or testing:

```bash
# 1. Copy example configuration
cp terraform.tfvars.example terraform.tfvars

# 2. Edit terraform.tfvars with your token
# konnect_pat = "kpat_YOUR_TOKEN_HERE"

# 3. Deploy
terraform init
terraform plan
terraform apply
```

**Resources created**: ~10 (control plane, portal, service, routes, plugins)

### Option B: Enhanced Deployment

Add specific features as needed:

```bash
# Create terraform.tfvars
cat > terraform.tfvars <<EOF
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"

# Enable features you want
enable_key_auth              = true
enable_request_transformer   = true
enable_proxy_cache           = true
enable_correlation_id        = true
EOF

terraform init
terraform apply
```

### Option C: From OpenAPI Spec (Original Workflow)

Use deck CLI to convert OpenAPI to Kong configuration:

```bash
# 1. Generate Kong config from OpenAPI
deck file openapi2kong --spec ./openapi.yaml --output-file kong.yaml
deck file add-plugins -s kong.yaml -o kong.yaml ./plugins/*
deck file patch -s kong.yaml -o kong.yaml ./patches/*

# 2. Convert to Terraform (optional - we already have TF files)
deck file kong2tf -s kong.yaml -o ./generated-service.tf

# 3. Deploy
terraform init
terraform apply
```

## 📁 Repository Structure

```
.
├── README.md                      # This file
├── TERRAFORM_GUIDE.md             # Complete documentation
├── SCENARIOS.md                   # Scenario-based examples
├── ENHANCEMENT_SUMMARY.md         # What's new
├── terraform.tfvars.example       # Configuration template
│
├── main.tf                        # Provider configuration
├── variables.tf                   # Input variables (80+)
├── outputs.tf                     # Output values
│
├── control-plane.tf               # Control plane & portal
├── service.tf                     # Services & routes
├── portal-api.tf                  # API catalog
├── consumers.tf                   # Consumers & credentials
├── plugins.tf                     # 20+ plugins
├── teams.tf                       # Teams & RBAC
├── upstreams.tf                   # Load balancing
├── vaults.tf                      # Secret management
├── certificates.tf                # Certificates & mTLS
├── dataplane.tf                   # Data plane config
│
├── openapi.yaml                   # API specification
├── kong.yaml                      # Generated Kong config
└── install.sh                     # Generation script
```

## 🌟 Features by Category

### 🔐 Authentication & Security
- **API Key** - Simple API key authentication
- **Basic Auth** - Username/password authentication
- **JWT** - JSON Web Token support
- **OAuth2** - OAuth2 application credentials
- **HMAC** - Signature verification
- **ACL** - Access control lists
- **mTLS** - Mutual TLS with certificates
- **IP Restriction** - Whitelist/blacklist

### 🚦 Traffic Management
- **Rate Limiting** - Advanced rate limiting with consumer groups
- **Request Size Limiting** - Payload size restrictions
- **Proxy Cache** - Response caching
- **Load Balancing** - Round-robin, canary deployments
- **Health Checks** - Active & passive health monitoring
- **Bot Detection** - Automated bot protection

### 🔄 Transformation & Routing
- **Request Transformer** - Modify request headers/body
- **Response Transformer** - Modify response headers/body
- **CORS** - Cross-origin resource sharing
- **Multiple Routes** - Path-based routing

### 📊 Observability
- **HTTP Logging** - External log aggregation
- **Correlation ID** - Request tracking across services
- **Datadog** - Metrics and monitoring integration

### 🏢 Enterprise
- **Teams & RBAC** - Role-based access control
- **Vaults** - AWS, GCP, Azure, HashiCorp integration
- **System Accounts** - Service account management
- **Cloud Gateway** - Managed data planes
- **Custom Domains** - TLS certificates and SNI
- **API Catalog** - Developer portal with OpenAPI specs

## 🎓 Learning Path

### Beginner (Week 1)
1. Start with **Scenario 1** (Basic API Gateway)
2. Review deployed resources in Kong Konnect UI
3. Test API endpoints

### Intermediate (Week 2-3)
4. Add authentication (**Scenario 2**: API Key)
5. Configure teams and RBAC (**Scenario 4**)
6. Enable monitoring (**Scenario 12**)

### Advanced (Week 4+)
7. Set up vault integration (**Scenario 8/9**)
8. Configure cloud gateway (**Scenario 10**)
9. Complete enterprise deployment (**Scenario 13**)

## 🧪 Testing Your Deployment

```bash
# Get control plane endpoint
ENDPOINT=$(terraform output -raw control_plane_endpoint)

# Test basic endpoint
curl -X GET "${ENDPOINT}/anything"

# Test with API key (if enabled)
curl -X GET "${ENDPOINT}/anything" -H "apikey: your-key"

# Test rate limiting (send 150 requests)
for i in {1..150}; do curl -X GET "${ENDPOINT}/anything"; done
```

See [SCENARIOS.md](./SCENARIOS.md) for more testing examples.

## 📋 Prerequisites

### Required Tools
- [Terraform](https://www.terraform.io/) >= 1.0
- [Deck CLI](https://github.com/kong/deck) (for OpenAPI conversion)
- Kong Konnect account with Personal Access Token

### Getting Your PAT
1. Log in to [Kong Konnect](https://cloud.konghq.com/)
2. Go to Settings → Personal Access Tokens
3. Create a new token with appropriate permissions
4. Copy the token (starts with `kpat_`)

## ⚙️ Configuration

### Minimal Configuration
```hcl
# terraform.tfvars
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"
```

### Production Configuration
```hcl
# terraform.tfvars
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"
konnect_region     = "au"

# Authentication
enable_key_auth    = true
enable_jwt_auth    = true

# Traffic Management
enable_proxy_cache          = true
enable_request_transformer  = true
enable_ip_restriction       = true
allowed_ips                 = ["10.0.0.0/8", "172.16.0.0/12"]

# Observability
enable_correlation_id = true
enable_http_log       = true
http_log_endpoint     = "https://logs.example.com/kong"

# Vault Integration
enable_hashicorp_vault = true
vault_host             = "vault.example.com"
vault_token            = "hvs.YOUR_VAULT_TOKEN"
```

## 🔒 Security Best Practices

1. **Never commit secrets** - Use `.gitignore` for `terraform.tfvars`
2. **Use remote state** - Store state in S3/GCS with encryption
3. **Enable vault integration** - Don't hardcode credentials
4. **Implement mTLS** - For production deployments
5. **Use system accounts** - For data plane authentication
6. **Enable IP restriction** - Limit access to known IPs

## 🐛 Troubleshooting

### Common Issues

**Error: Invalid token**
- Verify your PAT is correct and not expired
- Check PAT has necessary permissions

**Error: Resource already exists**
- Resource may exist from previous run
- Use `terraform import` or change resource names

**Error: User not found (team memberships)**
- Users must be created in Konnect UI first
- Set `enable_team_memberships = false` to skip

See [TERRAFORM_GUIDE.md](./TERRAFORM_GUIDE.md) for more troubleshooting.

## 📊 What Gets Deployed

### Minimal Deployment (~10 resources)
- 1 Control Plane
- 1 Developer Portal
- 1 Service (HTTPBin API)
- 2 Routes (GET, POST)
- 2 Plugins (CORS, Rate Limiting)
- API Catalog entries

### Full Deployment (80+ resources)
- All of the above, plus:
- 6 Consumers with different auth types
- 20+ Plugins across all categories
- 2 Upstreams with 4 Targets
- 3 Teams with role assignments
- 5 Vault integrations (configurable)
- Certificate and key management
- Data plane configuration
- System accounts

## 🤝 Contributing

Improvements and additions are welcome! Areas to enhance:
- Additional plugin configurations
- More deployment scenarios
- Multi-region setups
- Service mesh configurations
- CI/CD pipeline examples

## 📖 Resources

- [Kong Konnect Documentation](https://docs.konghq.com/konnect/)
- [Terraform Provider Docs](https://registry.terraform.io/providers/Kong/konnect/latest/docs)
- [Kong Plugin Hub](https://docs.konghq.com/hub/)
- [Deck CLI Documentation](https://docs.konghq.com/deck/)
- [Kong Community Forum](https://discuss.konghq.com/)

## 📝 License

See LICENSE file for details.

---

**Quick Links:**
- 📖 [Full Documentation](./TERRAFORM_GUIDE.md)
- 🎯 [Scenario Examples](./SCENARIOS.md)
- 📊 [What's New](./ENHANCEMENT_SUMMARY.md)
- ⚙️ [Configuration Template](./terraform.tfvars.example)
