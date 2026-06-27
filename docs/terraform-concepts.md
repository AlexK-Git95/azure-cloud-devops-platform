# Terraform Concepts

Terraform is an Infrastructure as Code tool used to define and manage infrastructure through configuration files.

## Key Concepts

- Provider: plugin used to interact with a platform such as Azure
- Resource: infrastructure object managed by Terraform
- Variable: input value used to make configuration reusable
- Output: value returned after infrastructure is applied
- State: Terraform's record of managed infrastructure

## Workflow

1. terraform init
2. terraform fmt
3. terraform validate
4. terraform plan
5. terraform apply

## Notes

Terraform compares the desired state in the configuration files with the actual infrastructure state and creates a plan for the required changes.

In team environments, Terraform state should usually be stored remotely rather than only on a local machine.