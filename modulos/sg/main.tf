### SEGURITY_GROUP
locals {
  rules_security_group = merge(
    {
      engress_rule = {
        from_port   = 0
        to_port     = 0
        protocol    = -1
        type        = "egress"
        cidr_blocks = ["0.0.0.0/0"]
      },
      ingress_rule = {
        from_port = 0
        to_port   = 0
        protocol  = -1
        type      = "ingress"
        self      = true
      }
    },
    var.rules_security_group,
  )
}

resource "aws_security_group" "this" {
  name        = format("%s-%s-sg", var.sgname, var.environment)
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    {
      "Name"     = format("%s-%s", var.sgname, var.environment)
      "Platform" = "network"
      "Type"     = "segurity-group"
    },
    var.tags,
  )
}

resource "aws_security_group_rule" "this" {

  for_each                 = local.rules_security_group
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  type                     = each.value.type
  security_group_id        = aws_security_group.this.id
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  description              = lookup(each.value, "description", null)
  self                     = lookup(each.value, "self", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)

  lifecycle {
    create_before_destroy = true
  }
}
