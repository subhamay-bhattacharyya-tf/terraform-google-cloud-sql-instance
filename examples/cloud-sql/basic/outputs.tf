# -- examples/cloud-sql/basic/outputs.tf (Example)
# ============================================================================
# Example: Basic Cloud SQL Database Instance - Outputs
# ============================================================================

output "instance_id" {
  description = "The ID of the Cloud SQL database instance"
  value       = module.cloud_sql_database_instance.instance_id
}

output "instance_name" {
  description = "The name of the Cloud SQL database instance"
  value       = module.cloud_sql_database_instance.instance_name
}

output "instance_project" {
  description = "The project ID where the instance is created"
  value       = module.cloud_sql_database_instance.instance_project
}

output "instance_location" {
  description = "The region of the Cloud SQL database instance"
  value       = module.cloud_sql_database_instance.instance_location
}

output "instance_self_link" {
  description = "The self link of the Cloud SQL database instance"
  value       = module.cloud_sql_database_instance.instance_self_link
}
