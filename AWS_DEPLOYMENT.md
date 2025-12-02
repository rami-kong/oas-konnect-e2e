# AWS Deployment Guide for Kong Konnect

## Overview

This configuration is optimized for AWS deployment, including native integrations with AWS services like Secrets Manager, Lambda, ElastiCache, RDS, Cognito, and more.

## AWS Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         AWS Cloud                            │
│                                                              │
│  ┌──────────────┐     ┌──────────────┐    ┌──────────────┐ │
│  │   Route 53   │────▶│     ALB      │────▶│ Kong Gateway │ │
│  └──────────────┘     └──────────────┘    └──────────────┘ │
│                                                   │          │
│  ┌──────────────┐     ┌──────────────┐          │          │
│  │   Secrets    │◀────│  Kong CP     │◀─────────┘          │
│  │   Manager    │     │  (Konnect)   │                     │
│  └──────────────┘     └──────────────┘                     │
│                                                              │
│  ┌──────────────┐     ┌──────────────┐    ┌──────────────┐ │
│  │ ElastiCache  │     │     RDS      │    │    Lambda    │ │
│  │   (Redis)    │     │ (PostgreSQL) │    │  Functions   │ │
│  └──────────────┘     └──────────────┘    └──────────────┘ │
│                                                              │
│  ┌──────────────┐     ┌──────────────┐    ┌──────────────┐ │
│  │  CloudWatch  │     │   Cognito    │    │     VPC      │ │
│  │     Logs     │     │              │    │   Peering    │ │
│  └──────────────┘     └──────────────┘    └──────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Prerequisites

### 1. AWS Account Setup
- AWS Account with appropriate permissions
- IAM role for Kong Konnect integration
- VPC configured (if using private connectivity)

### 2. Kong Konnect Account
- Kong Konnect account (US region recommended)
- Personal Access Token (PAT)
- Control Plane created

### 3. Required AWS Services (Optional)
Enable based on your needs:
- ✅ **AWS Secrets Manager**: For credential storage (recommended)
- ⚪ **AWS ElastiCache**: For distributed rate limiting
- ⚪ **AWS RDS**: For OAuth2 token storage
- ⚪ **AWS Lambda**: For serverless integrations
- ⚪ **AWS Cognito**: For user authentication
- ⚪ **AWS CloudWatch**: For logging and monitoring
- ⚪ **AWS Route 53**: For custom domains
- ⚪ **AWS ACM**: For TLS certificates
- ⚪ **AWS Transit Gateway**: For VPC connectivity

## Quick Start (AWS Deployment)

### 1. Basic AWS Deployment

```hcl
# terraform.tfvars
konnect_token      = "kpat_YOUR_TOKEN"
konnect_server_url = "https://us.api.konghq.com"
konnect_region     = "us"
environment        = "production"

# AWS Configuration
aws_deployment     = true
aws_region         = "us-east-1"
enable_aws_vault   = true
aws_cost_center    = "engineering"
aws_owner_email    = "devops@example.com"
```

Deploy:
```bash
terraform init
terraform plan
terraform apply
```

### 2. AWS with Multi-Region Setup

```hcl
# terraform.tfvars
konnect_token            = "kpat_YOUR_TOKEN"
aws_deployment           = true
aws_region               = "us-east-1"
aws_secondary_region     = "us-west-2"
enable_aws_multi_region  = true
enable_aws_vault         = true
```

### 3. AWS with ElastiCache (High Performance)

```hcl
# terraform.tfvars
enable_aws_elasticache      = true
aws_elasticache_endpoint    = "your-cluster.cache.amazonaws.com"
aws_elasticache_port        = 6379
aws_elasticache_password    = "your-redis-password"
aws_elasticache_ssl         = true
```

### 4. AWS with Lambda Integration

```hcl
# terraform.tfvars
enable_aws_lambda           = true
aws_lambda_function_name    = "api-processor"
aws_lambda_role_arn         = "arn:aws:iam::ACCOUNT:role/KongLambdaRole"
aws_lambda_invocation_type  = "RequestResponse"
```

### 5. AWS with Cognito Authentication

```hcl
# terraform.tfvars
enable_aws_cognito         = true
aws_cognito_user_pool_id   = "us-east-1_XXXXX"
aws_cognito_region         = "us-east-1"
```

## AWS Service Integrations

### AWS Secrets Manager

**Purpose**: Secure credential storage for API keys, OAuth tokens, etc.

**Setup**:
1. Create secrets in AWS Secrets Manager
2. Grant Kong IAM role access to secrets
3. Enable in Terraform:
```hcl
enable_aws_vault = true
aws_region       = "us-east-1"
```

**Usage in Kong**:
```bash
# Reference secret in plugin configuration
{vault://aws-sm-us-east-1/api-key}
```

**Benefits**:
- Centralized secret management
- Automatic rotation support
- Audit logging via CloudTrail
- Multi-region replication

### AWS ElastiCache (Redis)

**Purpose**: Distributed rate limiting and caching across multiple Kong instances.

**Setup**:
1. Create ElastiCache Redis cluster
2. Configure security groups for Kong access
3. Enable in Terraform:
```hcl
enable_aws_elasticache   = true
aws_elasticache_endpoint = "cluster.xxxxx.cache.amazonaws.com"
aws_elasticache_password = "your-password"
```

**Benefits**:
- Shared rate limit counters
- High performance (sub-millisecond latency)
- Automatic failover
- Multi-AZ deployment

### AWS RDS (PostgreSQL)

**Purpose**: OAuth2 token storage for centralized authentication.

**Setup**:
1. Create RDS PostgreSQL instance
2. Initialize Kong OAuth2 schema
3. Enable in Terraform:
```hcl
enable_aws_rds_oauth = true
aws_rds_endpoint     = "db.xxxxx.rds.amazonaws.com"
aws_rds_username     = "kong"
aws_rds_password     = "password"
aws_rds_database     = "kong_oauth2"
```

**Benefits**:
- Persistent token storage
- Automated backups
- Read replicas for scalability
- Multi-AZ for high availability

### AWS Lambda

**Purpose**: Serverless request/response processing.

**Setup**:
1. Deploy Lambda function
2. Create IAM role with invoke permissions
3. Enable in Terraform:
```hcl
enable_aws_lambda        = true
aws_lambda_function_name = "api-processor"
aws_lambda_role_arn      = "arn:aws:iam::ACCOUNT:role/Role"
```

**Use Cases**:
- Custom authentication logic
- Request transformation
- Data enrichment
- External service integration

### AWS Cognito

**Purpose**: User authentication and authorization.

**Setup**:
1. Create Cognito User Pool
2. Configure app clients
3. Enable JWT verification in Kong:
```hcl
enable_aws_cognito       = true
aws_cognito_user_pool_id = "us-east-1_XXXXX"
```

**Benefits**:
- Built-in user management
- Social identity providers
- MFA support
- Hosted UI for login

### AWS CloudWatch

**Purpose**: Centralized logging and monitoring.

**Setup**:
1. Create CloudWatch Log Group
2. Configure IAM permissions
3. Enable logging:
```hcl
enable_aws_cloudwatch = true
```

**Benefits**:
- Centralized log aggregation
- Real-time monitoring
- Alerting capabilities
- Integration with AWS X-Ray

### AWS Route 53 & ACM

**Purpose**: Custom domains with TLS certificates.

**Setup**:
1. Create Route 53 hosted zone
2. Request ACM certificate
3. Configure in Terraform:
```hcl
enable_aws_custom_domain = true
enable_aws_acm_cert      = true
aws_custom_domain        = "api.example.com"
```

**Benefits**:
- Automated DNS management
- Free TLS certificates
- Auto-renewal
- Multi-region support

### AWS Transit Gateway

**Purpose**: Private connectivity to VPC resources.

**Setup**:
1. Create Transit Gateway
2. Share via Resource Access Manager (RAM)
3. Configure in Terraform:
```hcl
enable_aws_transit_gateway = true
aws_transit_gateway_id     = "tgw-xxxxx"
aws_ram_share_arn          = "arn:aws:ram:..."
aws_vpc_cidrs              = ["10.0.0.0/16"]
```

**Benefits**:
- Private API access
- No internet exposure
- Simplified network architecture
- Multi-VPC connectivity

## IAM Permissions

### Required IAM Policy for Kong Konnect

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ],
      "Resource": "arn:aws:secretsmanager:*:*:secret:kong/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "lambda:InvokeFunction"
      ],
      "Resource": "arn:aws:lambda:*:*:function:kong-*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:log-group:/aws/kong/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "elasticache:DescribeCacheClusters",
        "elasticache:DescribeReplicationGroups"
      ],
      "Resource": "*"
    }
  ]
}
```

### Trust Policy for Cross-Account Access

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::KONNECT_ACCOUNT_ID:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "YOUR_EXTERNAL_ID"
        }
      }
    }
  ]
}
```

## Cost Optimization

### AWS Cost Allocation Tags

Automatically applied to all resources:
```hcl
aws_tags = {
  ManagedBy   = "terraform"
  Environment = "production"
  Project     = "kong-konnect"
  CostCenter  = "engineering"
  Owner       = "devops@example.com"
}
```

### Cost-Saving Tips

1. **Use ElastiCache strategically**
   - Start with t3.micro for testing
   - Scale based on actual needs
   - Consider reserved instances for production

2. **RDS optimization**
   - Use appropriate instance sizes
   - Enable Performance Insights only when needed
   - Consider Aurora Serverless for variable workloads

3. **Lambda optimization**
   - Right-size memory allocation
   - Use provisioned concurrency sparingly
   - Monitor cold starts

4. **Data transfer costs**
   - Use same-region resources
   - Enable VPC endpoints for AWS services
   - Consider CloudFront for static content

## Multi-Region Setup

### Active-Active Configuration

```hcl
# Primary region (us-east-1)
aws_region               = "us-east-1"
enable_aws_multi_region  = true

# Secondary region (us-west-2)
aws_secondary_region     = "us-west-2"

# Configure Route 53 health checks and failover
enable_aws_custom_domain = true
aws_custom_domain        = "api.example.com"
```

### Disaster Recovery

```hcl
# Enable cross-region replication
enable_aws_multi_region = true

# Secrets Manager replication
aws_region           = "us-east-1"
aws_secondary_region = "us-west-2"

# RDS cross-region read replicas
enable_aws_rds_oauth = true
# Configure read replicas in secondary region
```

## Monitoring & Observability

### CloudWatch Metrics

Key metrics to monitor:
- Request count
- Latency (p50, p95, p99)
- Error rate (4xx, 5xx)
- Rate limit hits
- Cache hit ratio

### CloudWatch Alarms

Recommended alarms:
```bash
# High error rate
aws cloudwatch put-metric-alarm \
  --alarm-name kong-high-error-rate \
  --metric-name 5xx_count \
  --threshold 100 \
  --evaluation-periods 2

# High latency
aws cloudwatch put-metric-alarm \
  --alarm-name kong-high-latency \
  --metric-name latency_p95 \
  --threshold 1000 \
  --evaluation-periods 3
```

### AWS X-Ray Integration

For distributed tracing:
```hcl
# Enable X-Ray in Lambda functions
# Kong supports X-Ray via plugins
```

## Security Best Practices

### 1. Network Security
- ✅ Use private subnets for Kong instances
- ✅ Enable VPC endpoints for AWS services
- ✅ Configure security groups with minimal access
- ✅ Use AWS WAF for API protection

### 2. Data Security
- ✅ Enable encryption at rest (RDS, ElastiCache, S3)
- ✅ Enable encryption in transit (TLS 1.2+)
- ✅ Use AWS Secrets Manager for credentials
- ✅ Enable CloudTrail for audit logging

### 3. Access Control
- ✅ Use IAM roles, not access keys
- ✅ Implement least privilege principle
- ✅ Enable MFA for sensitive operations
- ✅ Regular access reviews

### 4. Compliance
- ✅ Enable AWS Config for compliance monitoring
- ✅ Use AWS Security Hub
- ✅ Implement AWS GuardDuty
- ✅ Regular security assessments

## Troubleshooting

### Common Issues

**1. Secrets Manager Access Denied**
```bash
# Verify IAM role permissions
aws secretsmanager get-secret-value \
  --secret-id kong/api-key \
  --region us-east-1
```

**2. ElastiCache Connection Failed**
```bash
# Check security group rules
# Verify network ACLs
# Test connection from Kong instance
redis-cli -h cluster.cache.amazonaws.com -p 6379
```

**3. Lambda Invocation Timeout**
```bash
# Increase timeout in configuration
# Check Lambda function logs
# Verify IAM role permissions
```

**4. RDS Connection Issues**
```bash
# Verify security groups
# Check parameter group settings
# Test connection
psql -h endpoint.rds.amazonaws.com -U kong -d kong_oauth2
```

## Example: Complete AWS Deployment

```hcl
# terraform.tfvars - Production AWS Setup

# Core
konnect_token      = "kpat_YOUR_TOKEN"
konnect_server_url = "https://us.api.konghq.com"
konnect_region     = "us"
environment        = "production"

# AWS
aws_deployment       = true
aws_region           = "us-east-1"
aws_secondary_region = "us-west-2"
aws_cost_center      = "platform"
aws_owner_email      = "platform@example.com"

# Secrets Manager
enable_aws_vault         = true
enable_aws_multi_region  = true

# ElastiCache for rate limiting
enable_aws_elasticache   = true
aws_elasticache_endpoint = "prod.xxxxx.cache.amazonaws.com"
aws_elasticache_password = var.elasticache_password
aws_elasticache_ssl      = true

# RDS for OAuth2
enable_aws_rds_oauth = true
aws_rds_endpoint     = "prod.xxxxx.rds.amazonaws.com"
aws_rds_username     = "kong"
aws_rds_password     = var.rds_password

# Custom domain
enable_aws_custom_domain = true
enable_aws_acm_cert      = true
aws_custom_domain        = "api.example.com"

# Monitoring
enable_aws_cloudwatch = true
enable_aws_datadog    = true

# VPC connectivity
enable_aws_transit_gateway = true
aws_transit_gateway_id     = "tgw-xxxxx"
aws_vpc_cidrs              = ["10.0.0.0/16"]
```

## Next Steps

1. Review [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
2. Set up AWS Cost Explorer for monitoring
3. Configure AWS Backup for disaster recovery
4. Implement infrastructure as code best practices
5. Set up CI/CD pipeline for Terraform deployments

## Support

- AWS Support: [AWS Support Center](https://console.aws.amazon.com/support/)
- Kong Konnect: [Kong Support Portal](https://support.konghq.com/)
- Community: [Kong Nation](https://discuss.konghq.com/)
