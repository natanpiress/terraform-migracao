locals {
  tags = {
    Environment = "hml"
  }
  environment = "hml"
}

module "sg" {
  source      = "git@github.com:elvenworks-ps/professional-services.git//terraform-modules//sg"
  sgname      = "sgteste"
  environment = local.environment
  vpc_id      = "vpc-abcabcabc"

  rules_security_group = {

    ## Rule ingress cidr_block
    ingress_rule_1 = {
      from_port   = 6379
      to_port     = 6379
      protocol    = "tcp"
      type        = "ingress"
      cidr_blocks = ["172.31.0.0/16"]
    }

    ## Rule ingress source_security
    ingress_rule_2 = {
      from_port                = 6379
      to_port                  = 6379
      protocol                 = "tcp"
      type                     = "ingress"
      source_security_group_id = "sg-abcabcabc"
    }
  }

  tags = local.tags

}
