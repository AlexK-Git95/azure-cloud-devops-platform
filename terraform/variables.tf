variable "project_name" {
  description = "Short project name used for resource naming."
  type        = string
  default     = "devops-platform"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "project_name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.environment))
    error_message = "environment must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "location" {
  description = "Azure region where resources will be created."
  type        = string
  default     = "westeurope"
}

variable "storage_account_prefix" {
  description = "Storage account name prefix. Must be lowercase letters and numbers only, maximum 18 characters."
  type        = string
  default     = "stdevopsplatdev"

  validation {
    condition     = can(regex("^[a-z0-9]{3,18}$", var.storage_account_prefix))
    error_message = "storage_account_prefix must be 3-18 characters and contain only lowercase letters and numbers."
  }
}