# ============================================================================
# Cloud SQL Database Instance - Outputs
# ============================================================================

output "instance_id" {
  description = "The ID of the Cloud SQL database instance."
  value       = google_sql_database_instance.this.id
}

output "instance_name" {
  description = "The name of the Cloud SQL database instance."
  value       = google_sql_database_instance.this.name
}

output "instance_project" {
  description = "The project ID where the instance is created."
  value       = google_sql_database_instance.this.project
}

output "instance_location" {
  description = "The region of the Cloud SQL database instance."
  value       = google_sql_database_instance.this.region
}

output "instance_url" {
  description = "The connection name of the Cloud SQL database instance."
  value       = google_sql_database_instance.this.connection_name
}

output "instance_self_link" {
  description = "The self link of the Cloud SQL database instance resource."
  value       = google_sql_database_instance.this.self_link
}

output "instance_disk_type" {
  description = "The disk type of the Cloud SQL database instance."
  value       = google_sql_database_instance.this.settings[0].disk_type
}

output "instance_deletion_protection" {
  description = "Whether deletion protection is enabled for the instance."
  value       = google_sql_database_instance.this.deletion_protection
}
