# ============================================================================
# API CATALOG MANAGEMENT
# ============================================================================

# NOTE: Primary API - Echo Service has been moved to api-catalog-generated.tf
# It is now managed by the automation script (scripts/automate-api-catalog.sh)
# The following resources are commented out to avoid duplication:
# - konnect_api.httpbin_api
# - konnect_api_specification.httpbin_spec
# - All konnect_api_document.httpbin_* resources
# - konnect_api_publication.httpbin_publication

/*
# All Echo Service resources have been moved to api-catalog-generated.tf
# See config/api-catalog-config.yaml for configuration
*/

# ============================================================================
# SECOND API - Example REST API
# ============================================================================

resource "konnect_api" "example_rest_api" {
  count       = var.enable_second_api ? 1 : 0
  name        = "Example REST API"
  version     = "v2.0.0"
  description = "Example REST API for demonstration purposes"
  labels = {
    environment = var.environment
    team        = "backend"
    managed_by  = "terraform"
    api_type    = "rest"
    lifecycle   = "staging"
  }
}

resource "konnect_api_publication" "example_rest_publication" {
  count                      = var.enable_second_api ? 1 : 0
  api_id                     = konnect_api.example_rest_api[0].id
  portal_id                  = konnect_portal.terraform_portal.id
  visibility                 = "private"
  auto_approve_registrations = false
}

# ============================================================================
# DEVELOPER PORTAL PAGES
# ============================================================================

# Home Page
resource "konnect_portal_page" "home" {
  portal_id   = konnect_portal.terraform_portal.id
  title       = "Welcome to Our API Developer Portal"
  slug        = "home"
  status      = "published"
  visibility  = "public"
  description = "Main landing page for developers"
  content     = <<-EOT
    # Welcome to the API Developer Portal
    
    ## Discover, Integrate, and Build
    
    Welcome to our comprehensive API developer portal. Here you'll find everything you need to integrate our APIs into your applications.
    
    ### 🚀 Quick Start
    
    1. **Browse APIs** - Explore our API catalog
    2. **Register** - Create your developer account
    3. **Create Application** - Generate your API credentials
    4. **Start Building** - Begin integrating our APIs
    
    ### 📚 Available APIs
    
    #### HTTPBin API (v1.0.0)
    HTTP request & response testing service with comprehensive endpoints for testing HTTP methods, headers, and authentication.
    
    [View Documentation →](/api/httpbin-api)
    
    ### 🔑 Authentication
    
    All our APIs use API key authentication. Once you create an application, you'll receive an API key that must be included in all requests.
    
    ### 💡 Need Help?
    
    - **Documentation**: Browse our comprehensive guides
    - **Support**: Contact api-support@example.com
    - **Community**: Join our developer community
    - **Status**: Check our API status page
    
    ### 📊 Developer Resources
    
    - [Getting Started Guide](/getting-started)
    - [Authentication Guide](/authentication)
    - [API Reference](/api-reference)
    - [Code Examples](/examples)
    - [Best Practices](/best-practices)
    - [FAQs](/faq)
    
    ## Latest Updates
    
    - ✅ HTTPBin API v1.0.0 now available
    - ✅ Enhanced rate limiting controls
    - ✅ New documentation portal
    - ✅ Developer sandbox environment
  EOT
}

# Getting Started Page
resource "konnect_portal_page" "getting_started" {
  portal_id   = konnect_portal.terraform_portal.id
  title       = "Getting Started Guide"
  slug        = "getting-started"
  status      = "published"
  visibility  = "public"
  description = "Quick start guide for developers"
  content     = <<-EOT
    # Getting Started Guide
    
    ## Step 1: Create Your Account
    
    1. Click "Sign Up" in the top right corner
    2. Fill in your details
    3. Verify your email address
    4. Complete your profile
    
    ## Step 2: Create an Application
    
    1. Log in to the Developer Portal
    2. Navigate to "My Applications"
    3. Click "Create Application"
    4. Provide application details:
       - **Name**: Your application name
       - **Description**: What your app does
       - **Callback URL**: For OAuth flows (optional)
    5. Submit and wait for approval (if required)
    
    ## Step 3: Get Your API Key
    
    Once your application is approved:
    1. Go to "My Applications"
    2. Click on your application
    3. Copy your API key
    4. Store it securely (never commit to version control!)
    
    ## Step 4: Make Your First API Call
    
    ### Using cURL
    
    ```bash
    curl -X GET "https://your-gateway-endpoint/anything" \
      -H "apikey: YOUR_API_KEY" \
      -H "Content-Type: application/json"
    ```
    
    ### Using Postman
    
    1. Create a new request
    2. Set method to GET
    3. Enter URL: `https://your-gateway-endpoint/anything`
    4. Add header: `apikey: YOUR_API_KEY`
    5. Send request
    
    ### Expected Response
    
    ```json
    {
      "args": {},
      "headers": {
        "Apikey": "YOUR_API_KEY",
        "Host": "your-gateway-endpoint"
      },
      "method": "GET",
      "url": "https://your-gateway-endpoint/anything"
    }
    ```
    
    ## Step 5: Explore API Documentation
    
    1. Browse the [API Catalog](/apis)
    2. Select an API
    3. Review the OpenAPI specification
    4. Try endpoints using the interactive documentation
    
    ## Next Steps
    
    - Read the [Authentication Guide](/authentication)
    - Review [Code Examples](/examples)
    - Check out [Best Practices](/best-practices)
    - Join our [Developer Community](https://community.example.com)
    
    ## Need Help?
    
    - Email: api-support@example.com
    - Chat: Available in the portal (bottom right)
    - Community: https://community.example.com
  EOT
}

# API Reference Page
resource "konnect_portal_page" "api_reference" {
  portal_id   = konnect_portal.terraform_portal.id
  title       = "API Reference"
  slug        = "api-reference"
  status      = "published"
  visibility  = "public"
  description = "Complete API reference documentation"
  content     = <<-EOT
    # API Reference
    
    ## Available APIs
    
    ### HTTPBin API v1.0.0
    
    **Base URL**: `https://your-gateway-endpoint`
    
    **Authentication**: API Key (Header: `apikey`)
    
    **Rate Limit**: 100 requests/minute (standard), 1000 requests/minute (premium)
    
    #### Endpoints
    
    | Method | Path | Description |
    |--------|------|-------------|
    | GET | /anything | Returns request data |
    | POST | /anything | Echo POST data |
    | GET | /headers | Return request headers |
    | GET | /ip | Return origin IP |
    | GET | /status/{code} | Return specific status |
    
    [View Full OpenAPI Specification →](/api/httpbin-api)
    
    ## Common Headers
    
    | Header | Required | Description |
    |--------|----------|-------------|
    | apikey | Yes | Your API key |
    | Content-Type | Recommended | application/json |
    | Accept | Optional | application/json |
    | X-Request-ID | Optional | Custom request ID |
    
    ## Response Codes
    
    | Code | Status | Description |
    |------|--------|-------------|
    | 200 | OK | Successful request |
    | 201 | Created | Resource created |
    | 400 | Bad Request | Invalid parameters |
    | 401 | Unauthorized | Invalid API key |
    | 403 | Forbidden | Insufficient permissions |
    | 429 | Too Many Requests | Rate limit exceeded |
    | 500 | Internal Server Error | Server error |
    | 503 | Service Unavailable | Temporary unavailable |
    
    ## Rate Limiting
    
    All APIs include rate limiting headers:
    
    - `X-RateLimit-Limit`: Your rate limit
    - `X-RateLimit-Remaining`: Remaining requests
    - `X-RateLimit-Reset`: Reset time (Unix timestamp)
    
    ## Pagination
    
    For endpoints that return lists, use these parameters:
    
    - `page`: Page number (default: 1)
    - `per_page`: Items per page (default: 20, max: 100)
    
    ## Versioning
    
    APIs are versioned in the URL path. Always use the latest stable version.
  EOT
}

# Best Practices Page
resource "konnect_portal_page" "best_practices" {
  portal_id   = konnect_portal.terraform_portal.id
  title       = "Best Practices"
  slug        = "best-practices"
  status      = "published"
  visibility  = "public"
  description = "API integration best practices"
  content     = <<-EOT
    # Best Practices
    
    ## Security
    
    ### API Key Management
    - ✅ Store API keys in environment variables
    - ✅ Never commit keys to version control
    - ✅ Rotate keys regularly (every 90 days)
    - ✅ Use different keys for different environments
    - ❌ Don't share API keys via email or chat
    - ❌ Don't hardcode keys in your application
    
    ### HTTPS Only
    - Always use HTTPS for API calls
    - Verify SSL certificates
    - Don't disable SSL verification
    
    ## Performance
    
    ### Caching
    - Cache responses when appropriate
    - Respect cache headers
    - Use ETags for conditional requests
    
    ### Rate Limiting
    - Monitor rate limit headers
    - Implement exponential backoff
    - Handle 429 responses gracefully
    
    ### Connection Pooling
    - Reuse HTTP connections
    - Set appropriate timeouts
    - Use keep-alive connections
    
    ## Error Handling
    
    ### Retry Logic
    ```python
    import time
    import requests
    
    def make_request_with_retry(url, max_retries=3):
        for attempt in range(max_retries):
            try:
                response = requests.get(url, headers={'apikey': API_KEY})
                response.raise_for_status()
                return response.json()
            except requests.exceptions.RequestException as e:
                if attempt == max_retries - 1:
                    raise
                time.sleep(2 ** attempt)  # Exponential backoff
    ```
    
    ### Handle All Status Codes
    - 2xx: Success - process response
    - 4xx: Client error - check request
    - 5xx: Server error - retry with backoff
    
    ## Monitoring
    
    ### Log Requests
    - Log all API requests and responses
    - Include request IDs for tracing
    - Monitor error rates
    - Track response times
    
    ### Set Up Alerts
    - Alert on high error rates
    - Alert on rate limit approaches
    - Monitor API availability
    
    ## Development
    
    ### Use Sandbox Environment
    - Test in sandbox before production
    - Use test API keys for development
    - Never test with production data
    
    ### Version Management
    - Pin to specific API versions
    - Test new versions before migrating
    - Plan for deprecations
    
    ## Integration Checklist
    
    Before going live, ensure you:
    
    - ✅ Implemented proper error handling
    - ✅ Added retry logic with backoff
    - ✅ Set up monitoring and alerts
    - ✅ Tested rate limiting scenarios
    - ✅ Secured API keys properly
    - ✅ Implemented logging
    - ✅ Tested in sandbox environment
    - ✅ Reviewed security best practices
    - ✅ Set up proper timeouts
    - ✅ Documented your integration
  EOT
}

# FAQ Page
resource "konnect_portal_page" "faq" {
  portal_id   = konnect_portal.terraform_portal.id
  title       = "Frequently Asked Questions"
  slug        = "faq"
  status      = "published"
  visibility  = "public"
  description = "Common questions and answers"
  content     = <<-EOT
    # Frequently Asked Questions
    
    ## General
    
    ### What APIs are available?
    Check our [API Catalog](/apis) for a complete list of available APIs and their documentation.
    
    ### How do I get started?
    Follow our [Getting Started Guide](/getting-started) for step-by-step instructions.
    
    ### Is there a sandbox environment?
    Yes, we provide a sandbox environment for testing. Contact support for access.
    
    ## Authentication
    
    ### How do I authenticate?
    All APIs use API key authentication. Include your API key in the `apikey` header of each request.
    
    ### Where do I find my API key?
    1. Log in to the Developer Portal
    2. Go to "My Applications"
    3. Select your application
    4. Your API key is displayed there
    
    ### Can I rotate my API key?
    Yes, you can generate a new API key anytime. The old key remains valid until you delete it.
    
    ### What if my API key is compromised?
    Delete the compromised key immediately and generate a new one. Contact support if you need assistance.
    
    ## Rate Limiting
    
    ### What are the rate limits?
    - Standard tier: 100 requests/minute
    - Premium tier: 1000 requests/minute
    
    ### How do I know my rate limit status?
    Check the rate limit headers in API responses:
    - `X-RateLimit-Limit`
    - `X-RateLimit-Remaining`
    - `X-RateLimit-Reset`
    
    ### What happens if I exceed the rate limit?
    You'll receive a 429 status code. Implement exponential backoff and retry after the reset time.
    
    ### Can I increase my rate limit?
    Yes, upgrade to a premium tier or contact sales for custom limits.
    
    ## Technical
    
    ### What response format do APIs use?
    All APIs return JSON responses with appropriate Content-Type headers.
    
    ### Do you support webhooks?
    Webhook support varies by API. Check individual API documentation for details.
    
    ### What's the API uptime SLA?
    - Standard tier: 99.5% uptime
    - Premium tier: 99.9% uptime
    
    ### Where can I check API status?
    Visit our status page at https://status.example.com
    
    ## Billing
    
    ### Is there a free tier?
    Yes, the standard tier with 100 requests/minute is free for registered developers.
    
    ### How is usage calculated?
    Usage is calculated based on successful API requests (2xx status codes).
    
    ### When am I billed?
    Billing occurs monthly for premium tiers. View usage in your account dashboard.
    
    ## Support
    
    ### How do I get help?
    - Email: api-support@example.com
    - Chat: Available in portal (bottom right)
    - Community: https://community.example.com
    
    ### What are support hours?
    - Standard support: Monday-Friday, 9am-5pm EST
    - Premium support: 24/7 with 1-hour response time
    
    ### How do I report a bug?
    Email api-support@example.com with:
    - Detailed description
    - Steps to reproduce
    - Request IDs
    - Expected vs actual behavior
  EOT
}