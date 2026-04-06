# -- examples/cloud-sql/basic/main.tf (Example)
# ============================================================================
# Example: Basic Cloud SQL Database Instance
# ============================================================================

module "cloud_sql_database_instance" {
  source = "../../.."

  environment  = var.environment
  project_code = var.project_code
  region       = var.region

  cloud_sql_database_instance_config = {
    base_name = var.base_name
    location  = var.region
  }
}
