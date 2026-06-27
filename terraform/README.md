# Terraform Azure Infrastructure

This folder contains a basic Terraform foundation for Azure infrastructure.

## Current Scope

The current Terraform configuration defines:

- Azure Resource Group
- Azure Storage Account
- Common resource tags
- Input variables
- Outputs

This is not a production infrastructure setup. It is a clean Infrastructure as Code foundation that can be extended later.

## Files

- `providers.tf` - required Terraform and provider configuration
- `variables.tf` - input variables
- `main.tf` - Azure resources and local values
- `outputs.tf` - output values after apply

## Terraform Workflow

From this folder:

```bash
terraform init
terraform fmt
terraform validate
terraform plan

## Future Improvements

Add Azure Container Registry
Add remote backend configuration
Add environment-specific variable files
Add CI validation for Terraform
Add deployment target for the containerized application