# ============================================================================
# Cloud SQL Database Instance - Variables
# ============================================================================

variable "environment" {
  description = "Deployment environment. One of: devl, test, prod."
  type        = string

  validation {
    condition     = contains(["devl", "test", "prod"], var.environment)
    error_message = "environment must be one of: devl, test, prod."
  }
}

variable "project_code" {
  description = "Short identifier used in resource naming standardization."
  type        = string

  validation {
    condition     = length(var.project_code) > 0
    error_message = "project_code must not be empty."
  }
}

variable "project_id" {
  description = "The GCP project ID where the Cloud SQL instance will be created."
  type        = string

  validation {
    condition     = length(var.project_id) > 0
    error_message = "project_id must not be empty."
  }
}

variable "region" {
  description = "GCP region."
  type        = string
  default     = "us-central1"
}

variable "cloud_sql_database_instance_config" {
  description = "Configuration object for the Cloud SQL database instance."
  type = object({
    base_name           = string
    location            = optional(string, "us-central1")
    database_version    = optional(string, "MYSQL_8_0")
    tier                = optional(string, "db-f1-micro")
    disk_size           = optional(number, 10)
    disk_type           = optional(string, "PD_SSD")
    availability_type   = optional(string, "ZONAL")
    deletion_protection = optional(bool, false)
  })

  validation {
    condition     = length(var.cloud_sql_database_instance_config.base_name) > 0 && length(var.cloud_sql_database_instance_config.base_name) <= 30
    error_message = "base_name must be non-empty and at most 30 characters."
  }

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.cloud_sql_database_instance_config.base_name))
    error_message = "base_name must contain only lowercase alphanumeric characters and dashes."
  }

  validation {
    condition     = contains(["PD_SSD", "PD_HDD"], var.cloud_sql_database_instance_config.disk_type)
    error_message = "disk_type must be one of: PD_SSD, PD_HDD."
  }

  validation {
    condition     = contains(["ZONAL", "REGIONAL"], var.cloud_sql_database_instance_config.availability_type)
    error_message = "availability_type must be one of: ZONAL, REGIONAL."
  }
}
