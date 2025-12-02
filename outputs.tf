// ...existing code...

output "aws_vault_id" {
  description = "ID of the AWS vault (if enabled)"
  value       = length(konnect_gateway_vault.aws_vault) > 0 ? konnect_gateway_vault.aws_vault[0].id : null
}

// ...existing code...