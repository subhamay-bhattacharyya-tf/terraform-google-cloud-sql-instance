# ============================================================================
# Cloud SQL Database Instance - Main
# Creates and manages a Google Cloud SQL database instance.
# ============================================================================

resource "google_sql_database_instance" "this" {
  name             = local.instance_name
  project          = var.project_code
  region           = var.cloud_sql_database_instance_config.location
  database_version = var.cloud_sql_database_instance_config.database_version

  deletion_protection = var.cloud_sql_database_instance_config.deletion_protection

  settings {
    tier              = var.cloud_sql_database_instance_config.tier
    availability_type = var.cloud_sql_database_instance_config.availability_type
    disk_size         = var.cloud_sql_database_instance_config.disk_size
    disk_type         = var.cloud_sql_database_instance_config.disk_type

    user_labels = {
      environment  = var.environment
      project_code = var.project_code
      managed-by   = "terraform"
    }
  }
}
