# API Catalog Automation

This directory contains automation for managing Kong Konnect API Catalog using infrastructure as code.

## Overview

The automation pipeline:
1. **Creates APIs** in the Kong Konnect Catalog
2. **Adds OpenAPI specifications** to each API
3. **Generates documentation** (Getting Started, API Reference)
4. **Associates APIs with Gateway Services** for routing
5. **Publishes APIs** to the Developer Portal

## Directory Structure

```
.
├── config/
│   └── api-catalog-config.yaml    # API definitions
├── specs/
│   ├── echo-service.json           # OpenAPI specifications
│   ├── payment-api.yaml
│   └── user-management.yaml
├── scripts/
│   └── automate-api-catalog.sh    # Automation script
└── .github/
    └── workflows/
        └── api-catalog-automation.yaml  # GitHub Actions workflow
```

## Quick Start

### 1. Define Your APIs

Edit `config/api-catalog-config.yaml`:

```yaml
apis:
  - name: "My API"
    version: "v1.0.0"
    description: "API description"
    spec_file: "my-api.yaml"
    gateway_service: "api.example.com"
    publish_to_portal: true
```

### 2. Add OpenAPI Specifications

Place your OpenAPI specs in the `specs/` directory:

```bash
cp my-api.yaml specs/
```

### 3. Run Automation Locally

```bash
# Install dependencies
brew install yq terraform

# Make script executable
chmod +x scripts/automate-api-catalog.sh

# Run automation
./scripts/automate-api-catalog.sh config/api-catalog-config.yaml
```

### 4. Review Generated Configuration

The script generates `api-catalog-generated.tf` with:
- API catalog entries
- API specifications
- API documentation
- Gateway services and routes
- Portal publications

### 5. Apply Changes

```bash
terraform init
terraform plan
terraform apply
```

## GitHub Actions Workflow

The automation runs automatically on:
- **Push to main**: Applies changes to production
- **Pull requests**: Shows preview of changes
- **Manual trigger**: Via workflow_dispatch

### Setup GitHub Actions

1. **Add Secret**: `KONNECT_TOKEN` in repository settings
2. **Push changes** to trigger workflow
3. **Review PR comments** for terraform plan preview

## Configuration Reference

### API Configuration

```yaml
apis:
  - name: "API Name"              # Required: Display name
    version: "v1.0.0"             # Required: API version
    description: "Description"    # Required: API description
    spec_file: "spec.yaml"        # Required: OpenAPI spec filename (in specs/)
    gateway_service: "host.com"   # Optional: Backend service host
    publish_to_portal: true       # Optional: Publish to dev portal (default: true)
```

### Global Settings

```yaml
settings:
  auto_approve_portal_requests: false
  default_rate_limit: 100
  enable_api_key_auth: true
  enable_analytics: true
```

## Features

### ✅ Automated API Creation
- Creates API entries in Konnect Catalog
- Uploads OpenAPI specifications
- Generates documentation automatically

### ✅ Gateway Integration
- Creates Gateway Services
- Configures routes with path-based routing
- Enables plugins (auth, rate limiting, etc.)

### ✅ Developer Portal
- Publishes APIs to portal
- Makes documentation available
- Enables API discovery

### ✅ CI/CD Ready
- GitHub Actions workflow included
- Automated validation
- PR preview for changes

## Examples

### Example 1: Simple API

```yaml
apis:
  - name: "Weather API"
    version: "v1.0.0"
    description: "Get weather forecasts"
    spec_file: "weather.yaml"
    gateway_service: "api.weather.com"
    publish_to_portal: true
```

### Example 2: Internal API (Not Published)

```yaml
apis:
  - name: "Internal Admin API"
    version: "v1.0.0"
    description: "Internal administrative functions"
    spec_file: "admin.yaml"
    gateway_service: "internal.api.com"
    publish_to_portal: false  # Keep private
```

### Example 3: Multiple APIs

```yaml
apis:
  - name: "Users API"
    version: "v2.0.0"
    description: "User management"
    spec_file: "users.yaml"
    gateway_service: "users.api.com"
    publish_to_portal: true
    
  - name: "Products API"
    version: "v1.5.0"
    description: "Product catalog"
    spec_file: "products.yaml"
    gateway_service: "products.api.com"
    publish_to_portal: true
    
  - name: "Orders API"
    version: "v3.0.0"
    description: "Order processing"
    spec_file: "orders.yaml"
    gateway_service: "orders.api.com"
    publish_to_portal: true
```

## Best Practices

1. **Version Control**: Keep all specs in version control
2. **Validation**: Use OpenAPI linters (Spectral) before committing
3. **Documentation**: Include comprehensive descriptions
4. **Naming**: Use consistent naming conventions
5. **Testing**: Test API specs locally before deploying

## Troubleshooting

### Script fails with "yq: command not found"

```bash
# macOS
brew install yq

# Linux
wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
chmod +x /usr/local/bin/yq
```

### Terraform errors

```bash
# Reinitialize Terraform
terraform init -upgrade

# Check configuration
terraform validate

# Review plan
terraform plan
```

### API not appearing in portal

- Check `publish_to_portal: true` in config
- Verify portal is created: `konnect_portal.terraform_portal`
- Check Terraform output for publication status

## Support

For issues or questions:
- Documentation: See inline comments in config files
- Terraform: https://registry.terraform.io/providers/kong/konnect/latest/docs
- Kong Konnect: https://docs.konghq.com/konnect/

## License

Copyright (c) 2025
