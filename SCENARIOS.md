# Kong Konnect Terraform - Quick Start Scenarios

## Scenario 1: Basic API Gateway (Minimal Setup)

**What it includes**: Control plane, portal, single service with routes, CORS, and rate limiting.

**terraform.tfvars**:
```hcl
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"
```

**Deploy**:
```bash
terraform init
terraform apply
```

**Resources created**: ~10 resources

---

## Scenario 2: API Gateway with Key Authentication

**What it includes**: Everything from Scenario 1 + API key authentication with consumers.

**terraform.tfvars**:
```hcl
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"

# Enable key auth
enable_key_auth = true
```

**Resources created**: ~12 resources

---

## Scenario 3: Multi-Auth API Gateway

**What it includes**: Multiple authentication methods (API Key, Basic, JWT, OAuth2).

**terraform.tfvars**:
```hcl
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"

# Enable multiple auth methods
enable_key_auth   = true
enable_basic_auth = true
enable_jwt_auth   = true
enable_oauth2     = true
enable_acl        = true
```

**Resources created**: ~25 resources

---

## Scenario 4: Enterprise Setup with Teams

**What it includes**: RBAC with teams and roles.

**terraform.tfvars**:
```hcl
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"

# Enable team management (requires existing users)
enable_team_memberships = true
platform_lead_user_id   = "your-user-id-1"
api_developer_user_id   = "your-user-id-2"
```

**Resources created**: ~18 resources (base + teams)

---

## Scenario 5: High Availability Setup

**What it includes**: Load balancing with health checks, multiple upstreams.

**Configuration**: Automatically included via `upstreams.tf`.

**Resources created**: ~20 resources (includes upstreams and targets)

---

## Scenario 6: Secure API Gateway (mTLS)

**What it includes**: Mutual TLS with client certificates.

**Preparation**:
```bash
mkdir -p certs
# Generate or place your certificates in certs/
```

**terraform.tfvars**:
```hcl
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"

# Enable mTLS
enable_mtls            = true
ca_certificate         = file("certs/ca.crt")
client_ca_certificate  = file("certs/client-ca.crt")
```

**Resources created**: ~14 resources

---

## Scenario 7: Custom Domain Setup

**What it includes**: TLS certificate with custom domain.

**terraform.tfvars**:
```hcl
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"

# Enable custom domain
enable_custom_domain = true
custom_domain        = "api.yourdomain.com"
server_certificate   = file("certs/server.crt")
server_private_key   = file("certs/server.key")
```

**Post-deployment**: Update DNS to point to Kong gateway endpoint.

**Resources created**: ~12 resources

---

## Scenario 8: Vault Integration (AWS)

**What it includes**: AWS Secrets Manager integration.

**terraform.tfvars**:
```hcl
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"

# Enable AWS vault
enable_aws_vault = true
aws_region       = "us-east-1"
```

**Prerequisites**: AWS credentials configured, IAM permissions for Secrets Manager.

**Resources created**: ~11 resources

---

## Scenario 9: HashiCorp Vault Integration

**What it includes**: Enterprise secrets management with HashiCorp Vault.

**terraform.tfvars**:
```hcl
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"

# Enable HashiCorp Vault
enable_hashicorp_vault = true
vault_host             = "vault.example.com"
vault_port             = 8200
vault_token            = "hvs.YOUR_VAULT_TOKEN"
```

**Prerequisites**: Running HashiCorp Vault instance.

**Resources created**: ~11 resources

---

## Scenario 10: Cloud Gateway (Managed Data Plane)

**What it includes**: Fully managed Kong Gateway in the cloud.

**terraform.tfvars**:
```hcl
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"

# Enable cloud gateway
enable_cloud_gateway        = true
control_plane_geo           = "au"
cloud_gateway_provider      = "aws"
cloud_gateway_region        = "ap-southeast-2"
cloud_gateway_base_rps      = 100
cloud_gateway_max_rps       = 10000
```

**Resources created**: ~12 resources

---

## Scenario 11: IP Whitelisting

**What it includes**: Restrict API access by IP addresses.

**terraform.tfvars**:
```hcl
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"

# Enable IP restriction
enable_ip_restriction = true
allowed_ips = [
  "10.0.0.0/8",
  "172.16.0.0/12",
  "203.0.113.0/24"
]
```

**Resources created**: ~11 resources

---

## Scenario 12: Observability & Monitoring

**What it includes**: Logging, correlation IDs, Datadog integration.

**terraform.tfvars**:
```hcl
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"

# Enable monitoring
enable_http_log       = true
http_log_endpoint     = "https://logs.example.com/kong"
enable_correlation_id = true
enable_datadog        = true
datadog_host          = "datadog-agent.example.com"
```

**Resources created**: ~13 resources

---

## Scenario 13: Complete Enterprise Deployment

**What it includes**: Everything - teams, multiple auth, vaults, monitoring, load balancing.

**terraform.tfvars**:
```hcl
konnect_pat        = "kpat_YOUR_TOKEN"
konnect_server_url = "https://au.api.konghq.com"
konnect_region     = "au"

# Authentication
enable_key_auth   = true
enable_jwt_auth   = true
enable_basic_auth = true
enable_acl        = true

# Plugins
enable_request_transformer  = true
enable_response_transformer = true
enable_proxy_cache          = true
enable_correlation_id       = true
enable_bot_detection        = true

# IP Restriction
enable_ip_restriction = true
allowed_ips = ["10.0.0.0/8", "172.16.0.0/12"]

# Monitoring
enable_http_log       = true
http_log_endpoint     = "https://logs.example.com/kong"
enable_datadog        = true
datadog_host          = "localhost"

# Vault
enable_hashicorp_vault = true
vault_host             = "vault.example.com"
vault_token            = "hvs.YOUR_TOKEN"
```

**Resources created**: ~40+ resources

---

## Common Commands

### Initialize
```bash
terraform init
```

### Validate Configuration
```bash
terraform validate
```

### Plan Changes
```bash
terraform plan
```

### Apply Changes
```bash
terraform apply
```

### Apply with Auto-Approve
```bash
terraform apply -auto-approve
```

### Destroy Everything
```bash
terraform destroy
```

### Target Specific Resources
```bash
# Apply only consumers
terraform apply -target=konnect_gateway_consumer.api_key_consumer

# Apply only plugins
terraform apply -target=module.plugins
```

### View Outputs
```bash
terraform output
```

### View Specific Output
```bash
terraform output control_plane_id
```

### Format Code
```bash
terraform fmt -recursive
```

---

## Testing Scenarios

### Test API Key Authentication
```bash
# Get the control plane endpoint
ENDPOINT=$(terraform output -raw control_plane_endpoint)

# Test without API key (should fail)
curl -X GET "${ENDPOINT}/anything"

# Test with API key (should succeed)
curl -X GET "${ENDPOINT}/anything" \
  -H "apikey: your-api-key"
```

### Test Rate Limiting
```bash
# Send multiple requests
for i in {1..150}; do
  curl -X GET "${ENDPOINT}/anything"
done
# After 100 requests, you should see 429 Too Many Requests
```

### Test Load Balancing
```bash
# Send requests to load-balanced route
for i in {1..10}; do
  curl -X GET "${ENDPOINT}/lb/anything"
done
# Observe distribution across targets in Kong Manager
```

### Test CORS
```bash
curl -X OPTIONS "${ENDPOINT}/anything" \
  -H "Origin: https://example.com" \
  -H "Access-Control-Request-Method: POST"
```

---

## Incremental Adoption

Start small and add features incrementally:

1. **Week 1**: Deploy Scenario 1 (Basic)
2. **Week 2**: Add authentication (Scenario 2)
3. **Week 3**: Add teams and RBAC (Scenario 4)
4. **Week 4**: Add monitoring (Scenario 12)
5. **Week 5**: Add vault integration (Scenario 8/9)

---

## Troubleshooting

### Error: "Resource already exists"
- Resource may have been created manually
- Use `terraform import` to import existing resources
- Or use different names in configuration

### Error: "Invalid token"
- Check your PAT is correct
- Ensure PAT has necessary permissions
- Token may have expired

### Error: "User not found" (team memberships)
- Users must exist in Konnect before adding to teams
- Use Kong Konnect UI to create users first
- Or disable team memberships: `enable_team_memberships = false`

### Plugin Configuration Errors
- Check plugin documentation for correct schema
- Validate JSON configuration
- Ensure plugin is compatible with your Kong version

---

## Best Practices

1. **Start Simple**: Begin with Scenario 1, add features incrementally
2. **Use Version Control**: Commit your `.tfvars` to a secure repo (encrypted)
3. **Remote State**: Use S3/GCS for state file in production
4. **Separate Environments**: Use workspaces or separate directories for dev/staging/prod
5. **Plan Before Apply**: Always run `terraform plan` first
6. **Modules**: Consider breaking into modules for reusability
7. **Documentation**: Keep TERRAFORM_GUIDE.md updated with your customizations

---

## Next Steps

- Review the [TERRAFORM_GUIDE.md](./TERRAFORM_GUIDE.md) for detailed documentation
- Check [Kong Konnect Docs](https://docs.konghq.com/konnect/) for platform features
- Explore [Plugin Hub](https://docs.konghq.com/hub/) for available plugins
- Join [Kong Community](https://discuss.konghq.com/) for support
