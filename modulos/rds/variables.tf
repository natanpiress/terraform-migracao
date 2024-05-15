variable "identifier" {
  description = "Name identifier"
  type        = string
}

variable "dbname" {
  description = "Name database"
  type        = string
}

variable "environment" {
  description = "Env tags"
  type        = string
}

variable "username" {
  description = "username database"
  type        = string
}

variable "password" {
  description = "password database"
  type        = string
}

variable "parametergroup" {
  description = "Parameter group database"
  type        = string
}

variable "allow_major_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically "
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ "
  type        = bool
  default     = false
}

variable "rds_subnets" {
  description = "Subnet-groups database"
  type        = list(any)
  default     = []
}

variable "dbengineversion" {
  description = "Version database"
  type        = string
  default     = "13.7"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "dbengine" {
  description = "Type engine database"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "Segurity groups RDS"
  type        = list(string)
  default     = []
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Instance tags to snapshots."
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically "
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled. "
  type        = bool
  default     = false
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled."
  type        = bool
  default     = false
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled"
  type        = string
  default     = "03:00-06:00"
}

variable "maintenance_window" {
  description = "The window to perform maintenance in"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "backup_retention_period" {
  description = "Backup retention"
  type        = number
  default     = 7
}

variable "performance_insights_enabled" {
  description = "specifies whether Performance Insights are enabled."
  type        = bool
  default     = false
}

variable "storage_encrypted" {
  description = "storage encrypted engine database"
  type        = bool
  default     = "false"
}

variable "storage_type" {
  description = "Type storage database"
  type        = string
  default     = "gp3"
}

variable "size" {
  description = "Size storage database"
  type        = number
  default     = 15
}

variable "dbinstanceclass" {
  description = "Type instance database"
  type        = string
  default     = "db.t2.micro"
}

variable "skip_final_snapshot" {
  description = "Final snapshot database"
  type        = bool
  default     = false
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier"
  type        = string
  default     = null
}

variable "replica_mode" {
  description = "Specifies whether the replica is in either mounted or open-read-only mode"
  type        = string
  default     = null
}

variable "iops" {
  type    = number
  default = null
}

variable "proxy_create" {
  type    = bool
  default = false

}

variable "iam_role_arn" {
  description = "Role ARN from IAM"
  type        = string
  default     = null
}

variable "sm-rds" {
  description = "RDS Secrets Manager"
  type        = string
  default     = null
}

variable "engine_family" {
  description = " The kinds of databases that the proxy can connect to. This value determines which database network protocol the proxy recognizes when it interprets network traffic to and from the database. The engine family applies to MySQL and PostgreSQL for both RDS and Aurora. Valid values are MYSQL and POSTGRESQL."
  type        = string
  default     = "POSTGRESQL"
}
