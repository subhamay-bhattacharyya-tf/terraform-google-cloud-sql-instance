# ============================================================================
# Cloud SQL Database Instance - Locals
# ============================================================================

locals {
  instance_name = "${var.project_code}-${var.cloud_sql_database_instance_config.base_name}-${var.cloud_sql_database_instance_config.location}-${var.environment}"
}
