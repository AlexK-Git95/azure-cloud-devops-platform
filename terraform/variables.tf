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