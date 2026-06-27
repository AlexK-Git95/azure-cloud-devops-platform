# Terraform Documentation

## Purpose

This folder contains a basic Terraform foundation for Azure infrastructure.

The goal is to demonstrate Infrastructure as Code structure and Terraform workflow, not to present this as production-ready infrastructure.

## Current Scope

The current Terraform configuration defines:

* Azure provider configuration
* Terraform provider version constraints
* Azure Resource Group
* Azure Storage Account
* Common resource tags
* Input variables
* Output values

The Terraform configuration is located in:

`terraform/`

## File Structure

```text
terraform/
  providers.tf
  variables.tf
  main.tf
  outputs.tf
  README.md
```

## Files

### providers.tf

Defines the required Terraform version and providers used by the project.

The project uses:

* `azurerm` provider for Azure resources
* `random` provider for generating a suffix used in resource naming

The AzureRM provider is configured with:

```hcl
provider "azurerm" {
  features {}
}
```

### variables.tf

Defines input variables used by the Terraform configuration.

Current variables include:

* `project_name`
* `environment`
* `location`
* storage account naming input, if configured

Variables make the configuration more reusable and reduce hardcoding.

### main.tf

Defines the main Azure resources.

Current resources include:

* Azure Resource Group
* Azure Storage Account
* Random suffix for safer storage account naming

The storage account depends on the resource group because it references the resource group name and location.

### outputs.tf

Defines output values that Terraform can show after apply.

Current outputs include:

* Resource group name
* Resource group location
* Storage account name
* Storage account ID

Outputs are useful because they expose important infrastructure values after Terraform creates or manages resources.

## Terraform Workflow

The standard workflow used for this project is:

```bash
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply
```

### terraform fmt

Formats Terraform files according to the standard Terraform style.

This is useful for readability and consistency.

### terraform init

Initializes the Terraform working directory and downloads the required provider plugins.

In this project, `terraform init` creates:

* `.terraform/` local provider/cache folder
* `.terraform.lock.hcl` provider lock file

The `.terraform/` folder should not be committed.

The `.terraform.lock.hcl` file should be committed because it locks provider versions and improves consistency across environments.

### terraform validate

Checks whether the Terraform configuration is valid.

This validates the structure and syntax of the Terraform files, but it does not create Azure resources.

### terraform plan

Shows what Terraform would create, change, or destroy.

This is an important safety step before applying infrastructure changes.

### terraform apply

Applies the planned changes and creates, updates, or destroys real cloud resources.

This command was intentionally not run yet for this project, because it would require Azure authentication and could create real billable resources.

## State

Terraform uses state to track the infrastructure it manages.

The state file connects the Terraform configuration with real cloud resources.

For local testing, Terraform may use a local state file.

In a real team environment, Terraform state should usually be stored remotely, for example in Azure Storage Account or Terraform Cloud, so that the team works from a shared and controlled state backend.

## Current Validation Status

The Terraform configuration has been checked with:

```bash
terraform fmt
terraform init
terraform validate
```

The configuration validates successfully.

No `terraform apply` has been executed yet.

## Why Apply Was Not Run

`terraform apply` was not run because this project is currently focused on demonstrating Terraform structure and workflow.

Running `apply` would create real Azure resources and could generate cloud cost.

Before applying in a real environment, the project would need:

* Azure authentication
* confirmed subscription
* naming and tagging standards
* cost awareness
* remote state/backend decision
* review of the Terraform plan

## Current Limitations

The current Terraform setup does not yet include:

* Remote backend configuration
* Azure Container Registry
* Application hosting target
* Networking
* Key Vault
* Environment-specific `.tfvars`
* CI validation for Terraform
* Production-grade security configuration

## Possible Next Improvements

Possible improvements include:

1. Add remote state backend using Azure Storage
2. Add Azure Container Registry for Docker images
3. Add environment-specific variable files
4. Add Terraform validation to the CI pipeline
5. Add a deployment target for the containerized application
6. Add resource naming and tagging standards
7. Add documentation for plan/apply approval workflow

## Summary

This Terraform setup is a clean Azure Infrastructure as Code foundation.

It demonstrates provider configuration, variables, resources, outputs, state awareness, and basic Terraform validation workflow.

It is intentionally limited in scope and should not be presented as production infrastructure.
