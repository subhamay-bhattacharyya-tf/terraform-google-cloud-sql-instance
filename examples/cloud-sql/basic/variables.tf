# -- examples/cloud-sql/basic/variables.tf (Example)
# ============================================================================
# Example: Basic Cloud SQL Database Instance - Variables
# ============================================================================

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "devl"
}

variable "project_code" {
  description = "Short identifier for naming standardization."
  type        = string
  default     = "demo"
}

variable "region" {
  description = "GCP region."
  type        = string
  default     = "us-central1"
}

variable "base_name" {
  description = "Base name for the Cloud SQL database instance."
  type        = string
  default     = "my-sql-instance"
}
