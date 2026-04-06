# -- examples/cloud-sql/basic/versions.tf (Example)
# ============================================================================
# Example: Basic Cloud SQL Database Instance - Version Requirements
# ============================================================================

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.23.0"
    }
  }
}

provider "google" {
  region = var.region
}
