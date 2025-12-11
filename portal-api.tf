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
  title       = "Kong API"
  slug        = "home"
  status      = "published"
  visibility  = "public"
  description = "Start building and innovating with our APIs"
  content     = <<-EOT
    ---
    title: Kong API
    description: Start building and innovating with our APIs
    ---

    ::page-section
    ---
    full-width: true
    background-color: "#FFFEF8"
    padding: "50px 25px 0 25px"
    ---
      ::page-hero
      ---
      full-width: true
      title-font-size: "clamp(24px, 3vw, 64px)"
      title-line-height: "clamp(42px, 5vw, 72px)"
      title-font-weight: "700"
      title-tag: "h1"
      description-font-size: "clamp(16px, 3vw, 24px)"
      description-line-height: "clamp(24px, 3vw, 32px)"
      description-font-weight: "400"
      image:
        src: "https://i.imgur.com/C6A0H4v.jpeg"
        position: "right"
        max-width: "65%"
      ---
      #title
      Kong API Dev Portal

      #description
      Code. Collaborate. Innovate. Your Gateway to Development Excellence.

      #actions
        ::button
        ---
        size: "large"
        to: "/getting-started"
        ---
        Get started
        ::


      ::
    ::

    ::page-section
    ---
    background-color: "#1a1a1a"
    full-width: true
    padding: "50px 25px"
    ---
      ::multi-column
      ---
      columns-breakpoints:
        mobile: 1
        phablet: 2
        tablet: 2
        laptop: 2
        desktop: 2
      styles: |
        h3 {
          font-size: clamp(20px, 4vw, 24px);
          line-height: 32px;
          margin: 15px 0 10px 0;    
          background: linear-gradient(93deg, #1456cb -1.94%, #00e3c0 102.56%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        width: max-content;
        }
        p {
          line-height: clamp(16px, 3vw, 24px);
          line-height: clamp(24px, 3vw, 32px)
          color: white;
        }
      ---
        ::container
        ---
        padding: clamp(5px, 3vw, 25px) 0
        ---
        <svg width="26" height="26" viewBox="0 0 26 26" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M18.2 15.3333L10.6667 7.79994L18.2 0.266602L25.7333 7.79994L18.2 15.3333ZM0 12.6666V1.99994H10.6667V12.6666H0ZM13.3333 25.9999V15.3333H24V25.9999H13.3333ZM0 25.9999V15.3333H10.6667V25.9999H0ZM2.66667 9.99994H8V4.6666H2.66667V9.99994ZM18.2333 11.5999L22 7.83327L18.2333 4.0666L14.4667 7.83327L18.2333 11.5999ZM16 23.3333H21.3333V17.9999H16V23.3333ZM2.66667 23.3333H8V17.9999H2.66667V23.3333Z" fill="var(--kui-color-background-primary)"/>
        </svg>

        ### Seamless Integration
        Easily connect with your existing systems using our well-documented and developer-friendly API.
        ::

        ::container
        ---
        padding: clamp(5px, 3vw, 25px) 0
        ---
        <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" clip-rule="evenodd" d="M20 2.66675L21.2728 5.39396L24 6.66675L21.2728 7.93954L20 10.6667L18.7272 7.93954L16 6.66675L18.7272 5.39396L20 2.66675ZM4.00001 24.0001C3.26668 24.0001 2.6389 23.739 2.11668 23.2167C1.59445 22.6945 1.33334 22.0667 1.33334 21.3334C1.33334 20.6001 1.59445 19.9723 2.11668 19.4501C2.6389 18.9279 3.26668 18.6667 4.00001 18.6667H4.35001C4.45001 18.6667 4.55557 18.689 4.66668 18.7334L10.7333 12.6667C10.6889 12.5556 10.6667 12.4501 10.6667 12.3501V12.0001C10.6667 11.2667 10.9278 10.639 11.45 10.1167C11.9722 9.59453 12.6 9.33342 13.3333 9.33342C14.0667 9.33342 14.6945 9.59453 15.2167 10.1167C15.7389 10.639 16 11.2667 16 12.0001C16 12.0445 15.9778 12.2667 15.9333 12.6667L19.3333 16.0667C19.4445 16.0223 19.55 16.0001 19.65 16.0001H20.35C20.45 16.0001 20.5556 16.0223 20.6667 16.0667L25.4 11.3334C25.3556 11.2223 25.3333 11.1167 25.3333 11.0167V10.6667C25.3333 9.93341 25.5945 9.30564 26.1167 8.78341C26.6389 8.26119 27.2667 8.00008 28 8.00008C28.7333 8.00008 29.3611 8.26119 29.8833 8.78341C30.4056 9.30564 30.6667 9.93341 30.6667 10.6667C30.6667 11.4001 30.4056 12.0279 29.8833 12.5501C29.3611 13.0723 28.7333 13.3334 28 13.3334H27.65C27.55 13.3334 27.4445 13.3112 27.3333 13.2667L22.6 18.0001C22.6445 18.1112 22.6667 18.2167 22.6667 18.3167V18.6667C22.6667 19.4001 22.4056 20.0279 21.8833 20.5501C21.3611 21.0723 20.7333 21.3334 20 21.3334C19.2667 21.3334 18.6389 21.0723 18.1167 20.5501C17.5945 20.0279 17.3333 19.4001 17.3333 18.6667V18.3167C17.3333 18.2167 17.3556 18.1112 17.4 18.0001L14 14.6001C13.8889 14.6445 13.7833 14.6667 13.6833 14.6667H13.3333C13.2889 14.6667 13.0667 14.6445 12.6667 14.6001L6.60001 20.6667C6.64445 20.7779 6.66668 20.8834 6.66668 20.9834V21.3334C6.66668 22.0667 6.40557 22.6945 5.88334 23.2167C5.36112 23.739 4.73334 24.0001 4.00001 24.0001ZM6.18187 9.81822L5.33334 8.00008L4.48482 9.81822L2.66668 10.6667L4.48482 11.5153L5.33334 13.3334L6.18187 11.5153L8.00001 10.6667L6.18187 9.81822Z" fill="var(--kui-color-background-primary)"/>
        </svg>

        ### Scalability & Performance
        Designed to handle high-demand workloads with lightning-fast response times.
        ::

        ::container
        ---
        padding: clamp(5px, 3vw, 25px) 0
        ---
        <svg width="22" height="28" viewBox="0 0 22 28" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M7.26668 18.8001L11 16.0001L14.6667 18.8001L13.2667 14.2667L17 11.3334H12.4667L11 6.80008L9.53334 11.3334H5.00001L8.66668 14.2667L7.26668 18.8001ZM11 27.3334C7.91112 26.5556 5.36112 24.7834 3.35001 22.0168C1.3389 19.2501 0.333344 16.1779 0.333344 12.8001V4.66675L11 0.666748L21.6667 4.66675V12.8001C21.6667 16.1779 20.6611 19.2501 18.65 22.0168C16.6389 24.7834 14.0889 26.5556 11 27.3334ZM11 24.5334C13.3111 23.8001 15.2222 22.3334 16.7333 20.1334C18.2445 17.9334 19 15.489 19 12.8001V6.50008L11 3.50008L3.00001 6.50008V12.8001C3.00001 15.489 3.75557 17.9334 5.26668 20.1334C6.77779 22.3334 8.6889 23.8001 11 24.5334Z" fill="var(--kui-color-background-primary)"/>
        </svg>

        ### Secure & Reliable
        Built with industry-standard authentication and encryption to keep your data safe.
        ::

        ::container
        ---
        padding: clamp(5px, 3vw, 25px) 0
        ---
        <svg width="22" height="28" viewBox="0 0 22 28" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M5.66668 22.0001H16.3333V19.3334H5.66668V22.0001ZM5.66668 16.6667H16.3333V14.0001H5.66668V16.6667ZM3.00001 27.3334C2.26668 27.3334 1.6389 27.0723 1.11668 26.5501C0.594455 26.0279 0.333344 25.4001 0.333344 24.6667V3.33341C0.333344 2.60008 0.594455 1.9723 1.11668 1.45008C1.6389 0.927859 2.26668 0.666748 3.00001 0.666748H13.6667L21.6667 8.66675V24.6667C21.6667 25.4001 21.4056 26.0279 20.8833 26.5501C20.3611 27.0723 19.7333 27.3334 19 27.3334H3.00001ZM12.3333 10.0001V3.33341H3.00001V24.6667H19V10.0001H12.3333Z" fill="var(--kui-color-background-primary)"/>
        </svg>

        ### Comprehensive Documentation
        Get started quickly with clear, detailed guides and interactive API exploration.
        ::
      ::
    ::

    ::page-section
    ---
    full-width: true
    padding: "50px 25px"
    ---
      ::page-hero
      ---
      title-font-size: clamp(24px, 5vw, 32px)
      title-tag: "h2"
      text-align: "center"
      title-line-height: "clamp(24px, 5vw, 28px)"
      title-font-weight: "700"
      description-font-weight: "400"
      description-font-size: clamp(16px, 3vw, 18px)
      description-line-height: clamp(24px, 3vw, 32px)
      styles: |
        p {
          color: var(--kui-color-text-neutral-stronger);
        }
      ---
      #title
      Popular APIs
      #description
      Explore, test, and understand API endpoints with real-time requests and responses.
      ::

      ::container
        ::apis-list
        ---
        page-size: 3
        pagination: false
        grid-columns-breakpoints:
          mobile: 3
          phablet: 3
          tablet: 3
          desktop: 3
        ---
        ::
      ::

    ::

    ::page-section
    ---
    full-width: true
    background-color: "#1a1a1a"
    padding: "50px 25px"
    styles: |
      background-image: repeating-radial-gradient(circle at 0 0, #1e1e1e00 0, #1c1a1a 10px), repeating-linear-gradient(#00000055, #111010);
    ---
      ::page-hero
      ---
      title-font-size: clamp(24px, 4vw, 32px)
      title-font-weight: "700"
      title-line-height: "32px"
      description-font-weight: "400"
      description-font-size: clamp(16px, 3vw, 20px)
      description-line-height: clamp(24px, 3vw, 32px)
      color: "var(--kui-color-text-primary)"
      full-width: true
      image:
        position: "right"
        border-radius: "8px"
        max-width: "70%"
        src: "https://storage.googleapis.com/se-dev-portal/assets/gorilla_car.jpg"
      styles: |
        svg {
          max-width: 100%;
          height: auto;
        }
        p {
          color: var(--kui-color-text-neutral-weak);
        }
      ---
      #title
      Start Exploring
      #description
      Read our Getting Started guide to learn more!


      #actions
        ::button
        ---
        size: "large"
        to: "/getting-started"
        ---
        Read more
        ::


      ::
    ::
  EOT
}

# Getting Started Page
resource "konnect_portal_page" "getting_started" {
  portal_id   = konnect_portal.terraform_portal.id
  title       = "Getting started"
  slug        = "getting-started"
  status      = "published"
  visibility  = "public"
  description = "Get started with our new Developer Portal!"
  content     = <<-EOT
    ---
    title: Getting started
    description: Get started with our new Developer Portal!
    ---

    ::page-section
    ---
    full-width: true
    ---

      ::page-hero
      ---
      full-width: true
      title-font-size: "clamp(24px, 5vw, 32px)"
      title-tag: "h2"
      text-align: "left"
      title-line-height: "clamp(32px, 3vw, 40px)"
      title-font-weight: "700"
      description-font-weight: "400"
      description-font-size: "clamp(16px, 3vw, 18px)"
      description-line-height: "clamp(24px, 3vw, 32px)"
      image:
        src: https://storage.googleapis.com/se-dev-portal/assets/bg-car.png

      styles: |
        p {
          color: var(--kui-color-text-neutral-stronger);
        }
      ---
      #title
      Getting Started with the Kong Konnect Dev Portal

      #description
      Welcome to the Kong Konnect Dev Portal! This guide will help you discover new APIs, explore their documentation, and subscribe to them via app registration so you can start consuming them in practice.
      ::

      ::page-section
      ---
      margin: "clamp(0, 3vw, 25px) 0"
      ---
      <hr>
      ::

      ::page-section
      ---
      full-width: true
      ---
        ::page-hero
        ---
        full-width: true
        title-font-size: "clamp(24px, 5vw, 32px)"
        title-tag: "h2"
        text-align: "center"
        title-line-height: "clamp(32px, 3vw, 40px)"
        title-font-weight: "700"
        description-font-weight: "400"
        description-font-size: "clamp(16px, 3vw, 18px)"
        description-line-height: "clamp(24px, 3vw, 32px)"
        styles: |
          p {
            color: var(--kui-color-text-neutral-stronger)
          }
        ---
        #title
        Start Building

        #description
        Discover new things. Innovate faster. Blaze a trail.

        ::
      ::

      ::page-section
      ---
      full-width: true
      ---
        ::multi-column
        ---
        gap: "48px"
        columns-breakpoints:
          mobile: 1
          desktop: 1
          laptop: 1
          phablet: 1
          tablet: 1
        ---
          ::page-hero
          ---
          full-width: true
          title-font-size: "clamp(20px, 5vw, 20px)"
          title-tag: "h4"
          text-align: "left"
          title-line-height: "clamp(24px, 3vw, 24px)"
          title-font-weight: "700"
          description-font-weight: "400"
          description-font-size: "clamp(14px, 3vw, 14px)"
          description-line-height: "clamp(20px, 3vw, 20px)"
          image:
            src: https://storage.googleapis.com/se-dev-portal/assets/discover_gorilla.png
            position: "right"
            max-width: "15vw"
            height: auto
          styles: |
            p {
              color: var(--kui-color-text-neutral-stronger);
            }
            svg {
              max-width: 100%;
              height: auto;
            }
          ---
          #title
          Step 1: Discover APIs in the Catalog

          #description
          The API Catalog is your gateway to all available APIs. Follow these steps to explore and find the API you need:

          - Log in to the Kong Konnect Dev Portal.
          - Navigate to the API Catalog from the main dashboard.
          - Use the Search Bar to find APIs by name, category, or keyword.
          - Click on an API to view its Overview Page, which provides a brief summary, versioning details, and access requirements.

          📌 Tip: Use filters to refine your search based on authentication type, protocol, or API version.

          #actions
            ::button
            ---
            appearance: "secondary"
            to: "/apis"
            ---
            API Catalog
            ::
          ::

          ::page-hero
          ---
          full-width: true
          title-font-size: "clamp(20px, 5vw, 20px)"
          title-tag: "h4"
          text-align: "left"
          title-line-height: "clamp(24px, 3vw, 24px)"
          title-font-weight: "700"
          description-font-weight: "400"
          description-font-size: "clamp(14px, 3vw, 14px)"
          description-line-height: "clamp(20px, 3vw, 20px)"
          image:
            src: https://storage.googleapis.com/se-dev-portal/assets/reading_gorilla.png
            position: "right"
            max-width: "15vw"
            height: auto
          styles: |
            p {
              color: var(--kui-color-text-neutral-stronger);
            }
          ---
          #title
          Step 2: Read the API Documentation

          #description
          Once you've found an API of interest, you need to understand how to use it effectively:

          - Select the API from the catalog to open its API Documentation Page.
          - Review the Endpoint List to see available operations (e.g., GET, POST, PUT, DELETE).
          - Check the Request and Response Examples to understand the expected data format.
          - Look at Authentication Details to determine if API keys, OAuth, or other credentials are required.

          📌 Tip: If available, use the API Explorer to make test calls and see real-time responses.

          #actions
            ::button
            ---
            appearance: "secondary"
            to: "/apis"
            ---
            API Catalog
            ::
          ::

          ::page-hero
          ---
          full-width: true
          title-font-size: "clamp(20px, 5vw, 20px)"
          title-tag: "h4"
          text-align: "left"
          title-line-height: "clamp(24px, 3vw, 24px)"
          title-font-weight: "700"
          description-font-weight: "400"
          description-font-size: "clamp(14px, 3vw, 14px)"
          description-line-height: "clamp(20px, 3vw, 20px)"
          image:
            src: https://storage.googleapis.com/se-dev-portal/assets/tech_gorilla.png
            position: "right"
            max-width: "15vw"
            height: auto
          styles: |
            p {
              color: var(--kui-color-text-neutral-stronger);
            }
            svg {
              max-width: 100%;
              height: auto;
            }
          ---
          #title
          Step 3: Subscribe to an API

          #description
          To start consuming an API, you may need to register an application and subscribe to it:

          - Go to the My Apps section in the Dev Portal.
          - Click Create New App and fill in the required details
          - Navigate to the API you want to subscribe to and click Request Access.
          - Select your registered app and submit the access request.
          - Use these credentials in your API requests as per the authentication requirements.

          📌 Tip: Some APIs require manual approval before access is granted.

          #actions
            ::button
            ---
            appearance: "secondary"
            to: "/apps"
            ---
            My Applications
            ::


          ::
        ::
      ::
      ::page-section
      ---
      full-width: true
      ---
        ::page-hero
        ---
        full-width: true
        title-font-size: "clamp(24px, 5vw, 32px)"
        title-tag: "h2"
        text-align: "center"
        title-line-height: "clamp(32px, 3vw, 40px)"
        title-font-weight: "700"
        description-font-weight: "400"
        description-font-size: "clamp(16px, 3vw, 18px)"
        description-line-height: "clamp(24px, 3vw, 32px)"
        styles: |
          p {
          color: var(--kui-color-text-neutral-stronger)
          }
        ---
        #title
        Next Steps
        #description
        Now you're ready to explore, integrate, and build with the power of Kong Konnect APIs! 🚀
          ::alert
          ---
          appearance: "success"
          show-icon: true
          title: "Test API calls"
          message: "Test API calls using tools like Insomnia or cURL."
          ---
          ::
          ::alert
          ---
          appearance: "success"
          show-icon: true
          title: "Integrate the API"
          message: "Integrate the API into your application following the documentation guidelines."
          ---
          ::
          ::alert
          ---
            appearance: "success"
            show-icon: true
            title: "Monitor API usage"
            message: "Monitor API usage and performance via the My Apps dashboard."
          ---
          ::
          ::alert
          ---
            appearance: "success"
            show-icon: true
            title: "Find your community"
            message: "Join the developer community for support and updates."
          ---
          ::
        ::
      ::
    ::
  EOT
}

# APIs Catalog Page
resource "konnect_portal_page" "apis" {
  portal_id   = konnect_portal.terraform_portal.id
  title       = "APIs"
  slug        = "apis"
  status      = "published"
  visibility  = "public"
  description = "API Products available in this Developer Portal."
  content     = <<-EOT
    ---
    title: APIs
    description: API Products available in this Developer Portal.
    ---

    ::page-section
    ---
    full-width: true
    ---
      ::page-hero
      ---
      full-width: true
      title-font-size: "clamp(24px, 5vw, 32px)"
      title-tag: "h2"
      text-align: "left"
      title-line-height: "clamp(32px, 3vw, 40px)"
      title-font-weight: "700"
      description-font-weight: "400"
      description-font-size: "clamp(16px, 3vw, 18px)"
      description-line-height: "clamp(24px, 3vw, 32px)"
      styles: |
        p {
          color: var(--kui-color-text-neutral-stronger);
        }
      ---
      #title
      Explore our APIs

      #description
      Explore, test, and understand API endpoints with real-time requests and responses.
      ::
    ::

    ::apis-list{:persistPageNumber="true"}
    ---
    enable-search: true
    page-size: 24
    pagination: true
    showFilter: true
    ---
    ::
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