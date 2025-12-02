# AWS Vault - DISABLED: "vault type not found" error
variable "enable_vault" {
  default = false
}

resource "konnect_gateway_vault" "aws_vault" {
  count = 0 # Disabled - vault type not supported

  control_plane_id = konnect_gateway_control_plane.terraform_cp.id
  name             = "aws-secrets-manager"
  description      = "AWS Secrets Manager integration"
  prefix           = "aws-sm"

  config = jsonencode({
    region = "us-east-1"
  })

  tags = ["aws", "secrets-manager"]
}