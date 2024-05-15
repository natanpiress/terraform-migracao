output "identifier" {
  description = "The database name"
  value       = aws_db_instance.this.identifier
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.this.arn
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.this.endpoint
}

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = aws_db_instance.this.id
}

output "db_instance_kms_key_id" {
  description = "The ARN for the KMS encryption key."
  value       = aws_db_instance.this.kms_key_id
}
