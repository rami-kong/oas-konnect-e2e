# Kong Konnect Terraform Best Practices Update

## Overview
This document summarizes the updates made to align the Kong Konnect Terraform configuration with official Kong examples and best practices from: https://github.com/Kong/terraform-provider-konnect/tree/main/examples/scenarios

## Changes Made

### 1. Portal Configuration (`control-plane.tf`)
**Updated**: `konnect_portal` resource

**Changes**:
- ✅ Added `display_name` attribute for better portal identification
- ✅ Added `description` attribute for portal documentation
- ✅ Added `default_page_visibility = "public"` for consistent page defaults
- ✅ Kept `force_destroy` variable for flexible cleanup control

**Benefits**:
- Better portal metadata and documentation
- Consistent with Kong's portal_v3.tf example
- Easier portal management and identification
- Safer cleanup with force_destroy option

**Before**:
```hcl
resource "konnect_portal" "terraform_portal" {
  name                      = var.portal_name
  force_destroy             = var.portal_force_destroy
  default_api_visibility    = var.default_api_visibility
  auto_approve_developers   = var.auto_approve_developers
  ...
}
```

**After**:
```hcl
resource "konnect_portal" "terraform_portal" {
  name                      = var.portal_name
  display_name              = "Developer Portal"
  description               = "Kong Konnect API Developer Portal - Managed by Terraform"
  force_destroy             = var.portal_force_destroy
  default_api_visibility    = var.default_api_visibility
  default_page_visibility   = "public"
  auto_approve_developers   = var.auto_approve_developers
  ...
}
```

### 2. Portal Page Slugs (`portal-api.tf`)
**Updated**: Home page slug format

**Changes**:
- ✅ Changed home page slug from `"/"` to `"home"`
- ✅ Follows Kong's recommended slug naming convention
- ✅ All other pages already follow correct pattern (no leading slash)

**Benefits**:
- Consistent slug naming across all portal pages
- Avoids potential routing conflicts
- Aligns with Kong's portal_page.tf examples
- Better URL structure for portal navigation

**Before**:
```hcl
resource "konnect_portal_page" "home" {
  portal_id   = konnect_portal.terraform_portal.id
  title       = "Welcome to Our API Developer Portal"
  slug        = "/"
  ...
}
```

**After**:
```hcl
resource "konnect_portal_page" "home" {
  portal_id   = konnect_portal.terraform_portal.id
  title       = "Welcome to Our API Developer Portal"
  slug        = "home"
  ...
}
```

### 3. API Resource Labels (`scripts/automate-api-catalog.sh`)
**Updated**: API catalog automation script

**Changes**:
- ✅ Added `api_type = "rest"` label to all generated APIs
- ✅ Added explicit `depends_on` for API specifications
- ✅ Enhanced labeling for better API categorization

**Benefits**:
- Better API organization and filtering
- Improved resource dependency management
- Aligns with Kong's api-builder-v3.tf example
- Enhanced API catalog metadata

**Before**:
```hcl
resource "konnect_api" "example_api" {
  name        = "Example API"
  version     = "1.0.0"
  description = "Example description"
  
  labels = {
    environment = var.environment
    managed_by  = "terraform"
    automated   = "true"
    team        = "platform"
  }
}
```

**After**:
```hcl
resource "konnect_api" "example_api" {
  name        = "Example API"
  version     = "1.0.0"
  description = "Example description"
  
  labels = {
    environment = var.environment
    managed_by  = "terraform"
    automated   = "true"
    team        = "platform"
    api_type    = "rest"
  }
}

resource "konnect_api_specification" "example_spec" {
  api_id  = konnect_api.example_api.id
  content = file("specs/example.yaml")
  type    = "oas3"
  
  depends_on = [konnect_api.example_api]
}
```

## Verification

### Portal Pages Slug Status
All portal pages now use correct slug format (no leading slash except root):
- ✅ `home` (updated from `/`)
- ✅ `getting-started` (already correct)
- ✅ `api-reference` (already correct)
- ✅ `best-practices` (already correct)
- ✅ `faq` (already correct)
- ✅ `announcements` (already correct)
- ✅ `status` (already correct)
- ✅ `terms` (already correct)
- ✅ `privacy` (already correct)

### Resource Dependencies
API resources now have explicit dependency chain:
```
konnect_api → konnect_api_specification → konnect_api_document → konnect_api_publication
```

## Kong Official Examples Referenced

### 1. portal_v3.tf
- Portal display_name and description
- Default page visibility
- Force destroy for cleanup
- Label structure

### 2. api-builder-v3.tf
- API labels and categorization
- Resource dependency patterns
- Specification type handling

### 3. portal_page.tf
- Slug naming conventions
- Status and visibility settings
- Content structure

## Next Steps

### Recommended Enhancements
1. **API Products**: Consider implementing `konnect_api_product` for grouping related APIs
   - See: examples/scenarios/publish-api-product.tf
   
2. **Service Catalog**: Enhance service metadata with custom_fields
   - See: examples/scenarios/service-catalog.tf
   
3. **Consumer Groups**: Implement rate limiting with consumer groups
   - See: examples/scenarios/consumer-groups.tf

4. **Authentication Strategies**: Add OAuth2, OIDC, or other auth methods
   - See: examples/scenarios/auth-strategies.tf

### Testing
Run the following commands to verify changes:

```bash
# Format Terraform files
terraform fmt -recursive

# Validate configuration
terraform validate

# Plan changes (should show updates for portal and home page)
terraform plan

# Apply changes
terraform apply
```

### Expected Plan Output
The plan should show:
- Update to `konnect_portal.terraform_portal` (3 attributes added)
- Update to `konnect_portal_page.home` (slug changed)
- No changes to other resources (consistent state)

## Benefits Summary

✅ **Compliance**: Configuration now follows Kong's official best practices
✅ **Maintainability**: Better labeling and organization
✅ **Documentation**: Enhanced metadata for portals and APIs
✅ **Consistency**: Uniform slug naming across portal pages
✅ **Reliability**: Explicit resource dependencies
✅ **Scalability**: Ready for advanced features (products, consumer groups)

## Resources

- [Kong Terraform Provider Examples](https://github.com/Kong/terraform-provider-konnect/tree/main/examples/scenarios)
- [Kong Konnect Documentation](https://docs.konghq.com/konnect/)
- [Terraform Registry - Kong Provider](https://registry.terraform.io/providers/Kong/konnect/latest/docs)

---

**Generated**: $(date)
**Updated By**: Kong Best Practices Alignment
**Configuration Version**: v3.1.0
