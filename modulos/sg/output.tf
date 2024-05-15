output "sg_id" {
  description = "The ID of the security group"
  value       = aws_security_group.this.id
}

output "sg_name" {
  description = "Output security group name"
  value       = aws_security_group.this.name
}