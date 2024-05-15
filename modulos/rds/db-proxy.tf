resource "aws_db_proxy" "this" {
  count = var.proxy_create ? 1 : 0
  
  name                   = var.identifier
  debug_logging          = false
  engine_family          = var.engine_family
  idle_client_timeout    = 1800
  require_tls            = true
  role_arn               = var.iam_role_arn
  vpc_security_group_ids = var.vpc_security_group_ids
  vpc_subnet_ids         = var.rds_subnets

  auth {
    auth_scheme = "SECRETS"
    description = "SecretsManager"
    iam_auth    = "DISABLED"
    secret_arn  = var.sm-rds
  }

  tags = merge(
    {
      "Name"     = format("%s-%s", var.identifier, var.environment)
      "Platform" = "RDS"
      "Type"     = "Proxy"
    },
    var.tags,
  )
}

resource "aws_db_proxy_target" "this" {
  count = var.proxy_create ? 1 : 0

  db_instance_identifier = aws_db_instance.this.id
  db_proxy_name          = aws_db_proxy.this[0].name
  target_group_name      = aws_db_proxy_default_target_group.this[0].name

}

resource "aws_db_proxy_default_target_group" "this" {
  count = var.proxy_create ? 1 : 0
  
  db_proxy_name = aws_db_proxy.this[0].name

}