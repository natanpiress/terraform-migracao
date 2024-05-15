resource "aws_db_instance" "this" {
  identifier                          = format("%s-%s", var.identifier, var.environment)
  allocated_storage                   = var.size
  storage_encrypted                   = var.storage_encrypted
  storage_type                        = var.storage_type
  db_name                             = var.dbname
  engine                              = var.dbengine
  engine_version                      = var.dbengineversion
  instance_class                      = var.dbinstanceclass
  username                            = var.username
  password                            = var.password
  db_subnet_group_name                = aws_db_subnet_group.this.id
  parameter_group_name                = var.parametergroup
  skip_final_snapshot                 = var.skip_final_snapshot
  publicly_accessible                 = var.publicly_accessible
  apply_immediately                   = var.apply_immediately
  vpc_security_group_ids              = var.vpc_security_group_ids
  maintenance_window                  = var.maintenance_window
  backup_retention_period             = var.backup_retention_period
  backup_window                       = var.backup_window
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  auto_minor_version_upgrade          = var.auto_minor_version_upgrade
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  performance_insights_enabled        = var.performance_insights_enabled
  deletion_protection                 = var.deletion_protection
  multi_az                            = var.multi_az
  replica_mode                        = var.replica_mode
  replicate_source_db                 = var.replicate_source_db
  iops                                = var.iops

  tags = merge(
    {
      "Name"     = format("%s-%s", var.identifier, var.environment)
      "Platform" = "RDS"
      "Type"     = "Database"
    },
    var.tags,
  )

}

resource "aws_db_subnet_group" "this" {
  name       = format("%s-%s", var.identifier, var.environment)
  subnet_ids = var.rds_subnets

  tags = {
    Name        = format("%s-%s", var.identifier, var.environment)
    Environment = var.environment
    Platform    = "rds"
    Type        = "group-sg"
  }
}
