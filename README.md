# OAS to Kong Konnect Terraform

This automated workflow simplifies the process of onboarding and managing APIs in Kong Konnect, making it easier for developers to focus on building applications, not infrastructure. Most developers are already familiar with OpenAPI/Swagger. By starting with a spec they already use to design and document APIs, there’s no need to learn Kong-specific formats or configurations. This lowers the barrier to entry.

This is an example, the flow is as follows:

1.  Takes an OpenAPI specification
2.  Generate the Kong configuration from the OpenAPI specification
3.  Apply plugins (policies) to the Kong configuration
4.  Converts the Kong configuration to Terraform
5.  Deploys the Terraform configuration to a Kong Konnect Control Plane
6.  Automatically adds and publish the API to the Kong Konnect Developer Portal


## Prerequisites

### Tools
- [Deck CLI](https://github.com/kong/deck)
- [Terraform](https://www.terraform.io/)

### Environment Variables

Set these before running Terraform:

```bash
export TF_VAR_control_plane_id="52ea7xxxxxx"
export KONNECT_TOKEN="kpat_xxxxxx"
export TF_VAR_konnect_server_url="https://us.api.konghq.com"
export TF_VAR_portal_id="1edcxxxxxxx"
```

## Quick Start

### 1. Generate Kong Configuration
```bash
deck file openapi2kong --spec ./openapi.yaml --output-file kong.yaml
deck file add-plugins -s kong.yaml -o kong.yaml ./plugins/*
deck file patch -s kong.yaml -o kong.yaml ./patches/*
deck file kong2tf -s kong.yaml -o ./service.tf
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Plan Deployment
```bash
# Make sure environment variables are set first
terraform plan
```

### 4. Apply Configuration
```bash
# Make sure environment variables are set first
terraform apply
```

### 5. Clean Up (Optional)
```bash
# Make sure environment variables are set first
terraform destroy
```

## Files

- `openapi.yaml` - Your API specification
- `install.sh` - Generation script from OpenAPI to Kong
- `portal-api.tf` - Portal resources
- `main.tf` - Provider configuration
- `variables.tf` - Variable definitions

## Configuration Files

### main.tf
- Sets up Kong Konnect providers (both regular and beta)
- Configures provider authentication

### variables.tf
- Defines required variables for Kong Konnect connection
- Includes control plane ID, PAT, server URL, and portal ID


### portal-api.tf
- Defines API resources for Kong Konnect portal
- Links APIs to services and publishes them to the portal
- Includes API specifications